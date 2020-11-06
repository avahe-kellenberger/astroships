import
  animatedentity,
  math/[vector2, polygon, rectangle],
  math/collision/collisionhull

export
  animatedentity,
  Rectangle

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
    center: newVector2(x, y)
  )
  result.velocity = Vector2()

template getBounds*(this: GameObject): Rectangle =
  if this.collisionHull != nil:
    this.collisionHull.getBounds()
  else:
    nil

