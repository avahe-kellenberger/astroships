import
  animatedentity,
  math/[vector2, polygon],
  math/collision/collisionhull

export
  animatedentity

type GameObject* = ref object of AnimatedEntity
  collisionHull*: CollisionHull
  velocity*: Vector2

proc newGameObject*(
  spritesheetIndex: int, 
  x, y: float,
  spriteWidth, spriteHeight: int
): GameObject =
  result = GameObject(
    flags: loPhysics,
    spritesheetIndex: spritesheetIndex,
    x: x,
    y: y
  )
  result.velocity = Vector2()

