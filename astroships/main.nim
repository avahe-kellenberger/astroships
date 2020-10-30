import nico

import random

import 
  api,
  objects/explosion as exp

# Random is used in different modules,
# and needs to be initialized globally.
randomize()

nico.init("nico", "ASTROSHIPS")
nico.createWindow("ASTROSHIPS", 1920 div 2, 1080 div 2, 4)
fixedSize(true)
integerScale(true)

var
  astroPal = loadPaletteFromGPL("pal/astroships.gpl")
  explosion: Explosion
  polyTest: Polygon

proc gameInit() =
  setPalette(astroPal)
  explosion = newExplosion(32, 15)
  polyTest = newPolygon([
    newVector2(50, 50),
    newVector2(100, 50),
    newVector2(100, 100),
    newVector2(50, 100)
  ])

proc gameUpdate(dt: float32) =
  explosion.rotation += 0.005
  explosion.update(dt)

proc gameDraw() =
  cls()

  setColor(1)
  print("click for explosion!", 10, 10)

  if (mousebtnp(0)):
    explosion.resetAnimation()

  explosion.render()
  polyTest.render()

nico.run(gameInit, gameUpdate, gameDraw)

