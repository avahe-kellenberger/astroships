import nico
import tables, sets, math
import
  ../vector2,
  ../rectangle,
  ../../gameobject

type SpatialCell = object
  id: string
  objects: HashSet[GameObject]

proc newSpatialCell(id: string): SpatialCell =
  SpatialCell(id: id)

template add(this: var SpatialCell, obj: GameObject) =
  this.objects.incl(obj)

iterator forEachObject(this: SpatialCell): GameObject =
  for obj in this.objects:
    yield obj

type SpatialGrid* = ref object
  cells: TableRef[string, SpatialCell]
  objectBounds: TableRef[GameObject, Rectangle]
  cellSize: Positive
  # Scalar from grid coords to game coords.
  gridToPixelScalar: float

proc newSpatialGrid*(width, height, cellSize: Positive): SpatialGrid =
  ## @param width:
  ##  The width of the grid.
  ##
  ## @param height:
  ##  The height of the grid.
  ##
  ## @param cellSize:
  ##  The size of each cell in the grid.
  ##  This should be approx. double the size of the average object.
  SpatialGrid(
    cells: newTable[string, SpatialCell](width * height),
    objectBounds: newTable[GameObject, Rectangle](width * height),
    cellSize: cellSize.int,
    gridToPixelScalar: 1.0 / cellSize.float
  )

template getKeyID(cellX, cellY: int): string =
  $cellX & "," & $cellY

proc add*(this: SpatialGrid, obj: GameObject): bool =
  ## Adds an object to the grid.
  if this.objectBounds.hasKey(obj):
    return false

  let
    x = int(obj.x / this.cellSize.float) * this.cellSize
    y = int(obj.y / this.cellSize.float) * this.cellSize
    keyID = getKeyID(x, y)

  var cell = this.cells.getOrDefault(keyID, newSpatialCell(keyID))
  cell.add(obj)
  this.objectBounds[obj] = obj.getBounds()

proc clear*(this: SpatialGrid) =
  ## Clears the entire grid.
  this.cells.clear()
  this.objectBounds.clear()

proc getScaledBounds(this: SpatialGrid, bounds: Rectangle): Rectangle =
  bounds.getScaledInstance(this.gridToPixelScalar)

iterator cellInBounds(this: SpatialGrid, queryRect: Rectangle): tuple[cellX, cellY: int] =
  let
    topLeft = queryRect.topLeft()
    bottomRight = queryRect.bottomRight()

  for x in floor(topLeft.x).int .. floor(bottomRight.x).int:
    for y in floor(topLeft.y).int .. floor(bottomRight.y).int:
      yield (x, y)

proc query*(this: SpatialGrid, bounds: Rectangle): HashSet[GameObject] =
  let scaledBounds: Rectangle = this.getScaledBounds(bounds)
  # Find all cells that intersect with the bounds.
  for cellX, cellY in this.cellInBounds(scaledBounds):
    let keyID = getKeyID(cellX, cellY)
    if this.cells.hasKey(keyID):
      let cell = this.cells[keyID]
      # Add all objects in each cell.
      for obj in cell.forEachObject:
        result.incl(obj)

