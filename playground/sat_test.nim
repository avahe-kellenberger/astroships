import nico
import random
import ../astroships/api

# Random is used in different modules,
# and needs to be initialized globally.
randomize()

const
  screenWidth = 1920 div 2
  screenHeight = 1080 div 2
  screenScale = 4

nico.init("nico", "SAT Playground")
nico.createWindow("SAT Playground", screenWidth, screenHeight, screenScale)
fixedSize(true)
integerScale(true)

type PolyObject = ref object of Entity

var
  astroPal = loadPaletteFromGPL("../../assets/pal/astroships.gpl")
  layer: PhysicsLayer
  poly1, poly2: PolyObject
  collisionResult: CollisionResult

proc newPolyObject(x, y: float, poly: Polygon): PolyObject =
  result = PolyObject(
    flags: loPhysics,
    center: initVector2(x, y)
  )
  result.collisionHull = newPolygonCollisionHull(poly)

method render(this: PolyObject) =
  this.collisionHull.render(this.center)

proc collisionListener(objA, objB: Entity, res: CollisionResult) =
  collisionResult = res

proc gameInit() =
  setPalette(astroPal)
  let grid = newSpatialGrid(screenWidth, screenHeight, 50)
  layer = newPhysicsLayer(grid)
  poly1 = newPolyObject(
    30, 20,
    newPolygon([
      initVector2(-25, -25),
      initVector2(25, -25),
      initVector2(25, 25),
      initVector2(-25, 25)
    ])
  )
  poly2 = newPolyObject(
    100, 50,
    newPolygon([
      initVector2(-25, -25),
      initVector2(25, -25),
      initVector2(25, 25),
      initVector2(-25, 25)
    ])
  )

  layer.add(poly1)
  layer.add(poly2)
  layer.addCollisionListener(collisionListener)

proc gameUpdate(dt: float32) =
  let m = mouse()
  collisionResult = nil
  poly1.center = initVector2(m[0], m[1])
  layer.update(dt)

proc renderCollisionResult =
  setColor(23)
  let x = screenWidth / 3
  var
    y = 72
    yOff = 16
  proc printLine(s: string) =
    print(s, x, y + yOff, 2)
    yOff += 18
  printLine "isCollisionOwnerA: " & $collisionResult.isCollisionOwnerA
  printLine "Intrusion: " & $collisionResult.intrusion
  printLine "Contact normal: " & $collisionResult.contactNormal
  printLine "Contact ratio: " & $collisionResult.contactRatio
  printLine "Contact point: " & $collisionResult.contactPoint

proc gameDraw() =
  cls()
  setColor(4)
  rectFill(0, 0, screenWidth, screenHeight)

  setColor(1)
  printc("SAT Playground", screenWidth / 2, 32, 4)

  setColor(22)
  poly1.render()

  setColor(3)
  poly2.render()

  if collisionResult != nil:
    renderCollisionResult()

nico.run(gameInit, gameUpdate, gameDraw)

