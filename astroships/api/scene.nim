import algorithm

import 
  layer, entity

export layer, entity

type Scene* = ref object of RootObj
  layers: seq[Layer]
  isLayerOrderValid*: bool

proc newScene*: Scene = 
  Scene(isLayerOrderValid: true)

proc invalidateLayerOrder(this: Scene) =
  this.isLayerOrderValid = false

proc addLayer*(this: Scene, layer: Layer) =
  this.layers.add(layer)
  layer.addZChangeListener(proc(oldZ, newZ: float) = this.invalidateLayerOrder())

template forEachLayer*(this: Scene, layer, body) =
  for l in this.layers:
    var layer: Layer = l
    body

proc sortLayers(this: Scene) =
  if not this.isLayerOrderValid:
    # this.layers = this.layers.sortedByIt(it.z)
    this.layers.sort[:Layer](
      proc (x, y: Layer): int {.closure.} = (x.z - y.z).int,
      SortOrder.Descending
    )

proc removeAllLayers*(this: Scene) =
  this.layers.setLen(0)

method update*(this: Scene, deltaTime: float) {.base.} =
  this.sortLayers()
  this.forEachLayer(layer):
    layer.update(deltaTime)

method render*(this: Scene) {.base.} =
  this.sortLayers()
  this.forEachLayer(layer):
    layer.render()

