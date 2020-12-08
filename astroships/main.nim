import nico
import random

import
  api,
  objects/explosion as exp,
  objects/player as plyr,
  objects/laser as lsr,
  gamelayer,
  api/material

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
  camera: Camera
  layer: PhysicsLayer
  rectObj: Entity
  player: Player
  laser: Laser
  collision = false
  control: Controller = newController()

proc collisionListener(objA, objB: Entity, res: CollisionResult) =
  collision = true

layer = newGameLayer(newSpatialGrid(windowWidth, windowHeight, 88))
layer.addCollisionListener(collisionListener)

let
  explosion = newExplosion(150, 50)
  radius = max(explosion.spriteWidth, explosion.spriteHeight).float * 0.5
  explosionHull = newCircleCollisionHull(newCircle(VectorZero, radius))

explosion.collisionHull = explosionHull
explosion.velocity = initVector2(0, 0)
layer.add(explosion)

proc gameInit() =
  setPalette(astroPal)

  control.debug = true

  player = newPlayer(control, 400, 400)
  laser = newLaser(200, 200)
  camera = newCamera(player, control)
  rectObj = newEntity(loPhysics, ROCK, 200, 115)
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
  layer.add(laser)

proc gameUpdate(dt: float32) =
  collision = false
  control.update(dt)
  camera.update(dt)
  layer.update(dt)

proc gameDraw() =
  cls()
  setCamera(camera.x - windowWidth div 2, camera.y - windowHeight div 2)
  setColor(0)
  rectfill(0, 0, windowWidth, windowHeight)

  layer.render()
  if rectObj.collisionHull != nil:
    setColor(1)
    rectObj.collisionHull.render(rectObj.center - rectObj.collisionHull.center)

  if collision:
    print("Collision!", 150, 20)

  control.render()

nico.run(gameInit, gameUpdate, gameDraw)

