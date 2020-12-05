{.experimental: "codeReordering".}

import api/physicslayer

type GameLayer* = ref object of PhysicsLayer

proc newGameLayer*(grid: SpatialGrid, z: float = 1.0): PhysicsLayer =
  result = GameLayer(spatialGrid: grid)
  result.z = z
  result.addCollisionListener(defaultListener)

proc defaultListener*(collisionOwner, collided: Entity, result: CollisionResult) =
  let massA: float = collisionOwner.getMass()
  let massB: float = collided.getMass()

  if massA <= 0 or massB <= 0:
    return

  # Move the objects out of each other's space.
  let invertedResult = result.flip()
  collisionOwner.translate(result.getMinimumTranslationVector() * 0.5)
  collided.translate(invertedResult.getMinimumTranslationVector() * 0.5)

  # Apply standard physics to both objects.
  let velA: Vector2 = collisionOwner.velocity
  let velB: Vector2 = collided.velocity

  var velAfterImpactA: Vector2
  var velAfterImpactB: Vector2

  if massA == massB:
    velAfterImpactA = velB
    velAfterImpactB = velA
  else:
    let minRestitution: float =
      min(
        collisionOwner.material.restitution,
        collided.material.restitution,
      )

    let massTotal: float = massA + massB
    velAfterImpactA = (velA * ((massA - massB) / massTotal)) + (velB * ((2 * massB) / massTotal)) * minRestitution
    velAfterImpactB = ((velB * ((massB - massA) / massTotal)) + (velA * ((2 * massA) / massTotal))) * minRestitution

  collisionOwner.velocity = velAfterImpactA
  collided.velocity = velAfterImpactB

