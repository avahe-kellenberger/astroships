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

proc newEntity*(flags: LayerObjectFlags): Entity =
  Entity(flags: flags)

method update*(this: Entity, deltaTime: float) {.base.} = discard

method render*(this: Entity) {.base.} = discard

