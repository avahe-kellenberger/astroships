import tables, sets, math
import
  ../vector2,
  ../rectangle,
  ../../gameobject

export
  sets,
  vector2,
  rectangle,
  gameobject

type
  SpatialCell = object
    cellID: string
    objects: HashSet[GameObject]
  SpatialGrid* = ref object
    cells: TableRef[string, SpatialCell]
    cellSize: Positive
    # Scalar from grid coords to game coords.
    gridToPixelScalar: float

proc newSpatialCell(cellID: string): SpatialCell = SpatialCell(cellID: cellID)

template add(this: var SpatialCell, obj: GameObject) =
  this.objects.incl(obj)

iterator forEachObject(this: SpatialCell): GameObject =
  for obj in this.objects:
    yield obj

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
    cellSize: cellSize.int,
    gridToPixelScalar: 1.0 / cellSize.float
  )

template getKeyID(cellX, cellY: int): string =
  $cellX & "," & $cellY

template scaleToGrid*(this: SpatialGrid, rect: Rectangle): Rectangle =
  rect.getScaledInstance(this.gridToPixelScalar)

iterator cellInBounds*(this: SpatialGrid, queryRect: Rectangle): tuple[x, y: int] =
  ## Finds each cell in the given bounds.
  ## @param queryRect:
  ##   A rectangle scaled to the size of the grid.
  let
    topLeft = queryRect.topLeft()
    bottomRight = queryRect.bottomRight()
  for x in floor(topLeft.x).int .. floor(bottomRight.x).int:
    for y in floor(topLeft.y).int .. floor(bottomRight.y).int:
      yield (x, y)

proc add*(this: SpatialGrid, obj: GameObject) =
  ## Adds an object to the grid.
  let objBounds = this.scaleToGrid(obj.getBounds())
  for cell in this.cellInBounds(objBounds):
    let keyID = getKeyID(cell.x, cell.y)

    if this.cells.hasKey(keyID) and obj in this.cells[keyID].objects:
      # Object is already in this cell.
      continue

    var cell = this.cells.getOrDefault(keyID, newSpatialCell(keyID))
    cell.add(obj)
    this.cells[keyID] = cell

proc query*(this: SpatialGrid, bounds: Rectangle): HashSet[GameObject] =
  let scaledBounds: Rectangle = this.scaleToGrid(bounds)
  # Find all cells that intersect with the bounds.
  for x, y in this.cellInBounds(scaledBounds):
    let keyID = getKeyID(x, y)
    if this.cells.hasKey(keyID):
      let cell = this.cells[keyID]
      # Add all objects in each cell.
      for obj in cell.forEachObject:
        result.incl(obj)

proc clear*(this: SpatialGrid) =
  ## Clears the entire grid.
  this.cells.clear()

