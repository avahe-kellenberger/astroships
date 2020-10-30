import unittest
import ../../astroships/api

suite "scene":

  test "layer order by Z":
    let
      scene = newScene()
      layer1 = newLayer(1.0)
      layer2 = newLayer(2.0)
      layer3 = newLayer(3.0)
      layer4 = newLayer(4.0)
      layer5 = newLayer(5.0)

    scene.addLayer(layer1)
    scene.addLayer(layer2)
    scene.addLayer(layer3)
    scene.addLayer(layer4)
    scene.addLayer(layer5)

    # Change layer5 to have the lowest z.
    layer5.z = 0.1

    # `update` sorts layers by descending z location.
    scene.update(0.1)

    var newLayerOrder: seq[Layer]
    scene.forEachLayer(layer):
      newLayerOrder.add(layer)

    # layer4 now has the highest z.
    check newLayerOrder[0] == layer4
    check newLayerOrder[1] == layer3
    check newLayerOrder[2] == layer2
    check newLayerOrder[3] == layer1
    # layer5 has the lowest z, so it is handled lastly.
    check newLayerOrder[4] == layer5
    

