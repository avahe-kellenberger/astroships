import sequtils
import nico
import ../api/animatedentity
import ../api/controller as cntrllr
import ../api/math/vector2
import ../api/math/collision/collisionhull
import ../api/material

export animatedentity

const
  spritesheet = "ship.png"
  spriteWidth = 16
  spriteHeight = 16
  decelerationMultiplier = 1.3

var spritesheetIndex = -1

# Pre-define our animations here.
# They are independent from nico, and are immutable.
let levelAnimation: Animation = newAnimation(0.0, toSeq(0..20))

type
  PlayerAnim* {.pure.} = enum
    # All animation names are derived from the enum.
    Level

  Player* = ref object of AnimatedEntity
    controller: Controller
    level*: Natural
    acceleration: float
    maxSpeed: float

# Implicitly convert enum names to a string.
converter animToString*(animation: PlayerAnim): string = $animation

proc newPlayer*(controller: Controller, x, y: int): Player =
  # Lazy init our spritesheetIndex because nico needs to load first.
  if spritesheetIndex < 0:
    spritesheetIndex = loadSpritesheet(spritesheet, spriteWidth, spriteHeight)
  result =
    Player(
      controller: controller,
      spritesheetIndex: spritesheetIndex,
      center: initVector2(x, y),
      material: METAL,
      spriteWidth: spriteWidth,
      spriteHeight: spriteHeight,
      acceleration: 800.0,
      maxSpeed: 300.0
    )
  result.flags = loPhysics

  # Add any animations we need.
  result.addAnimation(Level, levelAnimation)
  # Be sure to set the animation when finished.
  result.setAnimation(Level)

  var playerCollisionShape = newPolygon(@[
    initVector2(-8, -8),
    initVector2(-8, 8),
    initVector2(8, 0)
  ])
  result.collisionHull = newPolygonCollisionHull(playerCollisionShape)

method updateCurrentAnimation(this: Player, deltaTime: float) =
  # Player animation is not updated by time.
  discard

method getCurrentAnimationFrame*(this: Player): AnimationFrame =
  return this.currentAnimation[this.level mod this.currentAnimation.frameCount]

method update*(this: Player, deltaTime: float) =
  procCall AnimatedEntity(this).update(deltaTime)

  let
    mouseLoc = this.controller.mouse.location
    direction = (mouseLoc - this.center).normalize()
    angleToMouse = direction.getAngleRadians()

  let deltaRotation = angleToMouse - this.rotation
  this.rotate(deltaRotation)

  if this.controller.accelerating:
    this.velocity = (
      this.velocity + (direction * this.acceleration * deltaTime)
     ).maxMagnitude(this.maxSpeed)
  elif this.controller.decelerating:
    this.velocity -= this.velocity * deltaTime * decelerationMultiplier

