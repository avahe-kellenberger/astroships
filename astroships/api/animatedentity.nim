## AnimatedEntity is an `Entity` with an animation system built in.
## AnimatedEntity's `LayerObjectFlags` is set to `loUpdateRender`.
import
  nico,
  tables

import
  entity,
  animation

export
  entity,
  animation

type AnimatedEntity* = ref object of Entity
  spritesheetIndex*: int
  animations: Table[string, Animation]
  currentAnimation: Animation
  currentAnimationTime: float

proc newAnimatedEntity*(spritesheetIndex: int): AnimatedEntity =
  AnimatedEntity(
    flags: loUpdateRender,
    spritesheetIndex: spritesheetIndex
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

method renderCurrentAnimation(this: AnimatedEntity) {.base.} =
  ## Renders the current animation frame.
  ## This is automatically invoked by render()
  setSpritesheet(this.spritesheetIndex)
  let frame = this.currentAnimation.getCurrentFrame(this.currentAnimationTime)
  spr(frame.index, 0, 0, hflip = frame.hflip, vflip = frame.vflip)

method update*(this: AnimatedEntity, deltaTime: float) =
  this.updateCurrentAnimation(deltaTime)

method render*(this: AnimatedEntity) =
  this.renderCurrentAnimation()

