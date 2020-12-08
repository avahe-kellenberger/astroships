import sequtils
import nico
import ../api/animatedentity
import ../api/material

export animatedentity

const
  spritesheet = "laser.png"
  spriteWidth = 48
  spriteHeight = 8

var spritesheetIndex = -1

const staticAnim = newAnimation(
  1.0,
  [0]
)

type Laser* = ref object of AnimatedEntity

proc newLaser*(x, y: int): Laser =
  # Lazy init our spritesheetIndex because nico needs to load first.
  if spritesheetIndex < 0:
    spritesheetIndex = loadSpritesheet(spritesheet, spriteWidth, spriteHeight)
  result =
    Laser(
      spritesheetIndex: spritesheetIndex,
      material: NULL,
      center: initVector2(x, y),
      spriteWidth: spriteWidth,
      spriteHeight: spriteHeight
    )
  result.flags = loPhysics
  result.addAnimation("static", staticAnim)
  result.setAnimation("static")

