import nico

import random

import
  api,
  objects/explosion as exp,
  objects/player as plyr

# Random is used in different modules,
# and needs to be initialized globally.
randomize()

const
  windowWidth = 1920 div 2
  windowHeight = 1080 div 2
  windowScale = 4

nico.init("nico", "ASTROSHIPS")
nico.createWindow("ASTROSHIPS", windowWidth, windowHeight, windowScale)
fixedSize(true)
integerScale(true)

var
  astroPal = loadPaletteFromGPL("pal/astroships.gpl")
  layer: PhysicsLayer
  rectObj: Entity
  player: Player
  collision = false

proc collisionListener(objA, objB: Entity, res: CollisionResult) =
  collision = true

proc gameInit() =
  setPalette(astroPal)

  layer = newPhysicsLayer(newSpatialGrid(windowWidth, windowHeight, 88))
  layer.addCollisionListener(collisionListener)

  let
    explosion = newExplosion(50, 50)
    radius = max(explosion.spriteWidth, explosion.spriteHeight).float * 0.5
    explosionHull = newCircleCollisionHull(newCircle(VectorZero, radius))

  explosion.collisionHull = explosionHull
  explosion.velocity = initVector2(10, 20)

  player = newPlayer(400, 400)
  rectObj = newEntity(loPhysics, 50, 115)
  let myRect = newPolygon([
    initVector2(-25, -25),
    initVector2(25, -25),
    initVector2(25, 25),
    initVector2(-25, 25)
  ])

  rectObj.collisionHull = newPolygonCollisionHull(myRect)
  layer.add(rectObj)
  layer.add(explosion)
  layer.add(player)

proc gameUpdate(dt: float32) =
  collision = false
  layer.update(dt)

  if keyp(K_l):
    player.level.inc

proc gameDraw() =
  cls()
  setColor(0)
  rectfill(0, 0, windowWidth, windowHeight)

  layer.render()
  if rectObj.collisionHull != nil:
    setColor(1)
    rectObj.collisionHull.render(rectObj.center - rectObj.collisionHull.center)

  if collision:
    print("Collision!", 150, 20)

nico.run(gameInit, gameUpdate, gameDraw)

