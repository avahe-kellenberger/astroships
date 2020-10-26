import ../api/animatedentity

export animatedentity

let explodeAnimation: Animation = newAnimation(
    0.05,
    [0,1,2,3,4,5,6,7,8,9,10,11]
)

type
    Explosion* = ref object of AnimatedEntity
        

proc newExplosion*(): Explosion =
    result = Explosion()
    result.spritesheetIndex = 0
    result.addAnimation("explode", explodeAnimation)
    result.setAnimation("explode")
