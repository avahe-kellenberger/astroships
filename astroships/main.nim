import nico, objects/explosion as exp

nico.init("nico", "ASTROSHIPS")
nico.createWindow("ASTROSHIPS", 128, 128, 4)
fixedSize(true)
integerScale(true)

var
  buttonDown = false
  frame = 0
  astroPal = loadPaletteFromGPL("pal/astroships.gpl")
  explosion: Explosion

proc gameInit() =
  setPalette(astroPal)
  explosion = newExplosion(32, 15)

proc gameUpdate(dt: float32) =
  frame += 1
  buttonDown = btn(pcA)
  explosion.rotation += 0.005
  explosion.update(dt)

proc gameDraw() =
  cls()

  setColor(1)
  print("click for explosion!", 10, 10)

  explosion.render()

  if (mousebtnp(0)):
    explosion.resetAnimation()

nico.run(gameInit, gameUpdate, gameDraw)

