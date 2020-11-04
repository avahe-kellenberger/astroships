## AnimatedEntity is an `Entity` with an animation system built in.
## AnimatedEntity's `LayerObjectFlags` is set to `loUpdateRender`.
import
  nico,
  tables

import
  entity,
  animation,
  spritesheetloader

export
  entity,
  animation,
  spritesheetloader

type AnimatedEntity* = ref object of Entity
  spritesheetIndex*: int
  spriteWidth*: int
  spriteHeight*: int
  animations: Table[string, Animation]
  currentAnimation: Animation
  currentAnimationTime: float
  rotation*: float

proc newAnimatedEntity*(
  spritesheetIndex: int,
  x, y: float,
  spriteWidth, spriteHeight: int = 1
): AnimatedEntity =
  AnimatedEntity(
    flags: loUpdateRender,
    spritesheetIndex: spritesheetIndex,
    center: newVector2(x, y),
    spriteWidth: spriteWidth,
    spriteHeight: spriteHeight
  )

method addAnimation*(this: AnimatedEntity, name: string, animation: Animation) {.base.} =
  this.animations[name] = animation

method resetAnimation*(this: AnimatedEntity) {.base.} =
  this.currentAnimationTime = 0f

method setAnimation*(this: AnimatedEntity, name: string) {.base.} =
  this.currentAnimation = this.animations[name]
  this.resetAnimation()

method updateCurrentAnimation(this: AnimatedEntity, deltaTime: float) {.base.} =
  ## Updates the animation based on elapsed time.
  ## This is automatically invoked by update()
  this.currentAnimationTime =
    (this.currentAnimationTime + deltaTime) mod this.currentAnimation.duration

method getCurrentAnimationFrame*(this: AnimatedEntity): AnimationFrame {.base.} =
  ## Gets the current animation frame to render.
  ## By default, it invokes `Animation.getCurrentFrame(this.currentAnimationTime)`
  return this.currentAnimation.getCurrentFrame(this.currentAnimationTime)

method renderCurrentAnimation(this: AnimatedEntity) {.base.} =
  ## Renders the current animation frame.
  ## This is automatically invoked by render()
  setSpritesheet(this.spritesheetIndex)
  let frame = this.getCurrentAnimationFrame()
  if this.rotation == 0.0:
    spr(frame.index, this.x.int, this.y.int, hflip = frame.hflip, vflip = frame.vflip)
  else:
    let
      centerX = (this.x + this.spriteWidth.float * 0.5).int
      centerY = (this.y + this.spriteHeight.float * 0.5).int
    # TODO: There's currently no way to flip AND rotate.
    sprRot(frame.index, centerX, centerY, this.rotation)

method update*(this: AnimatedEntity, deltaTime: float) =
  this.updateCurrentAnimation(deltaTime)

method render*(this: AnimatedEntity) =
  this.renderCurrentAnimation()

