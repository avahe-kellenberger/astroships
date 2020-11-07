import tables, sets, math
import
  ../vector2,
  ../rectangle,
  ../../entity

export
  sets,
  vector2,
  rectangle,
  entity

type
  SpatialCell = object
    cellID: string
    entities: HashSet[Entity]
  SpatialGrid* = ref object
    # All entities is the grid.
    entities: HashSet[Entity]
    cells: TableRef[string, SpatialCell]
    cellSize: Positive
    # Scalar from grid coords to game coords.
    gridToPixelScalar: float

proc newSpatialCell(cellID: string): SpatialCell = SpatialCell(cellID: cellID)

template add(this: var SpatialCell, entity: Entity) =
  this.entities.incl(entity)

iterator forEachEntity(this: SpatialCell): Entity =
  for entity in this.entities:
    yield entity

proc newSpatialGrid*(width, height, cellSize: Positive): SpatialGrid =
  ## @param width:
  ##  The width of the grid.
  ##
  ## @param height:
  ##  The height of the grid.
  ##
  ## @param cellSize:
  ##  The size of each cell in the grid.
  ##  This should be approx. double the size of the average entity.
  SpatialGrid(
    cells: newTable[string, SpatialCell](width * height),
    cellSize: cellSize.int,
    gridToPixelScalar: 1.0 / cellSize.float
  )

iterator items*(this: SpatialGrid): Entity =
  for e in this.entities:
    yield e

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

proc add*(this: SpatialGrid, entity: Entity) =
  ## Adds an entity to the grid.
  ## If the entity's bounds are nil, this proc will do nothing.
  if entity.bounds() == nil or
     not entity.flags.includes(loPhysics):
    return

  # Register the entity in the grid.
  this.entities.incl(entity)

  # Add the entity to all cells its bounds intersect with.
  let entityBounds = this.scaleToGrid(entity.bounds())
  for cell in this.cellInBounds(entityBounds):
    let keyID = getKeyID(cell.x, cell.y)
    var cell = this.cells.getOrDefault(keyID, newSpatialCell(keyID))
    cell.add(entity)
    this.cells[keyID] = cell

proc query*(this: SpatialGrid, bounds: Rectangle): HashSet[Entity] =
  let scaledBounds: Rectangle = this.scaleToGrid(bounds)
  # Find all cells that intersect with the bounds.
  for x, y in this.cellInBounds(scaledBounds):
    let keyID = getKeyID(x, y)
    if this.cells.hasKey(keyID):
      let cell = this.cells[keyID]
      # Add all entityects in each cell.
      for entity in cell.forEachEntity:
        result.incl(entity)

proc clear*(this: SpatialGrid) =
  ## Clears the entire grid.
  this.cells.clear()
  this.entities.clear()

