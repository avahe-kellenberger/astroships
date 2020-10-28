import
  animatedentity,
  math/[vector2, polygon]

export
  animatedentity

type GameObject* = ref object of AnimatedEntity
  collisionHull*: Polygon
  velocity*: Vector2

proc newGameObject*(
  spritesheetIndex: int, 
  x, y: float,
  spriteWidth, spriteHeight: int
): GameObject =
  GameObject(
    flags: loPhysics,
    spritesheetIndex: spritesheetIndex,
    x: x,
    y: y
  )

