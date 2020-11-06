import unittest, sequtils
import ../../../../astroships/api

const cellSize = 20

suite "spatialgrid":

  var grid = newSpatialGrid(20, 20, cellSize)

  # Called before every test.
  setup:
    grid.clear()

  test "Add and query an object":
    var obj = newGameObject(
      spritesheetIndex = 0,
      x = 45,
      y = 85,
      spriteWidth = 20,
      spriteHeight = 20
    )

    let objCenter = obj.center
    obj.collisionHull = newCircleCollisionHull(newCircle(objCenter, 10))

    let objBounds = obj.getBounds()
    check objBounds != nil

    ## Add the object to the grid after creating its collision hull.
    grid.add(obj)

    # Query the grid at the object's location.
    let queriedObjects = grid.query(objBounds)
    check queriedObjects.len == 1
    check obj in queriedObjects

    let
      boundsInGrid = grid.scaleToGrid(objBounds)
      cells = toSeq(grid.cellInBounds(boundsInGrid))

    check cells == @[
      (1, 3),
      (1, 4),
      (2, 3),
      (2, 4)
    ]

