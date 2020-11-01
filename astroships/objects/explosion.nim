import sequtils
import ../api/gameobject

export gameobject

const
  spritesheet = "explosion.png"
  spriteWidth = 32
  spriteHeight = 32

var spritesheetIndex = -1

# Pre-define our animations here.
# They are independent from nico, and are immutable.
let explodeAnimation: Animation = newAnimation(0.05, toSeq(0..11))

type
  ExplosionAnim* {.pure.} = enum 
    # All animation names are derived from the enum.
    Explode

  Explosion* = ref object of GameObject

# Implicitly convert enum names to a string.
converter animToString*(animation: ExplosionAnim): string = $animation

proc newExplosion*(x, y: int): Explosion =
  # Lazy init our spritesheetIndex because nico needs to load first.
  if spritesheetIndex < 0:
    spritesheetIndex = loadSpritesheet(spritesheet, spriteWidth, spriteHeight)
  result =
    Explosion(
      spritesheetIndex: spritesheetIndex,
      center: newVector2(x, y),
      spriteWidth: spriteWidth,
      spriteHeight: spriteHeight
    )

  # Add any animations we need.
  result.addAnimation(Explode, explodeAnimation)

  # Be sure to set the animation when finished.
  result.setAnimation(Explode)

