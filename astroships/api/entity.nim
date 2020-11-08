import hashes
import
  math/[vector2, rectangle],
  math/collision/collisionhull

export vector2, rectangle, collisionhull

## Flags indicating how the object should be treated by a layer.
type LayerObjectFlags* = enum
  ## Only update
  loUpdate = 0b1
  ## Only render
  loRender = 0b10
  ## Render and update
  loUpdateRender = loUpdate.int or loRender.int
  ## Render, update, and use in physics
  loPhysics = loUpdateRender.int or 0b100

template includes*(this, flags: LayerObjectFlags): bool =
  (this.int and flags.int) == flags.int

type Entity* = ref object of RootObj
  flags*: LayerObjectFlags
  center*: Vector2
  # Pixels per second.
  velocity*: Vector2
  lastMoveVector*: Vector2
  collisionHull*: CollisionHull

proc newEntity*(flags: LayerObjectFlags, x, y: float = 0f): Entity =
  result = Entity(
    flags: flags,
    center: initVector2(x, y)
  )

template x*(this: Entity): float = this.center.x
template y*(this: Entity): float = this.center.y

method bounds*(this: Entity): Rectangle {.base.} =
  ## Gets the bounds of the Entity's collision hull.
  ## The bounds are relative to the center of the object.
  if this.collisionHull != nil:
    return this.collisionHull.getBounds()

method hash*(this: Entity): Hash {.base.} = hash(this[].unsafeAddr)

method update*(this: Entity, deltaTime: float) {.base.} =
  this.lastMoveVector = this.velocity * deltaTime
  this.center += this.lastMoveVector

method render*(this: Entity) {.base.} = discard

