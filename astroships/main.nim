import nico, objects/explosion as exp

nico.init("nico", "ASTROSHIPS")
nico.createWindow("ASTROSHIPS", 1920 div 2, 1080 div 2, 4)
fixedSize(true)
integerScale(true)

var
  astroPal = loadPaletteFromGPL("pal/astroships.gpl")
  explosion: Explosion

proc gameInit() =
  setPalette(astroPal)
  explosion = newExplosion(32, 15)

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

nico.run(gameInit, gameUpdate, gameDraw)

