import unittest
import ../../astroships/api

var 
  updateCallCount = 0
  renderCallCount = 0

type TestEntity = ref object of Entity

proc newTestEntity(flags: LayerObjectFlags): TestEntity =
  TestEntity(flags: flags)

method update(this: TestEntity, deltaTime: float) = updateCallCount.inc
method render(this: TestEntity) = renderCallCount.inc

suite "layer":

  # Called before every test.
  setup:
    updateCallCount = 0
    renderCallCount = 0

  test "update and render":
    let
      layer: Layer = newLayer()
      e1 = newTestEntity(loUpdate)
      e2 = newTestEntity(loRender)
      e3 = newTestEntity(loUpdateRender)
      e4 = newTestEntity(loUpdateRender)
      e5 = newTestEntity(loUpdateRender)
      e6 = newTestEntity(loRender)

    layer.add(e1)
    layer.add(e2)
    layer.add(e3)
    layer.add(e4)
    layer.add(e5)
    layer.add(e6)

    layer.update(0.1)
    layer.render()
    
    check updateCallCount == 4
    check renderCallCount == 5

