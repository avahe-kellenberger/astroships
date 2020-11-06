import hashes
import math/vector2

export vector2

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

template `and`*(flagsA, flagsB: LayerObjectFlags): bool =
  (flagsA.int and flagsB.int) != 0

template `or`*(flagsA, flagsB: LayerObjectFlags): bool =
  (flagsA.int or flagsB.int) != 0

type Entity* = ref object of RootObj
  flags*: LayerObjectFlags
  center*: Vector2

proc newEntity*(flags: LayerObjectFlags, x, y: float = 0f): Entity =
  Entity(
    flags: flags,
    center: newVector2(x, y)
  )

template x*(this: Entity): float = this.center.x
template y*(this: Entity): float = this.center.y

method hash*(this: Entity): Hash {.base.} = hash(this[].unsafeAddr)

method update*(this: Entity, deltaTime: float) {.base.} = discard

method render*(this: Entity) {.base.} = discard

