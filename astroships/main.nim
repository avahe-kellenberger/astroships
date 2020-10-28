import nico, objects/explosion as exp, api/controller as ctrl

nico.init("nico", "ASTROSHIPS")
nico.createWindow("ASTROSHIPS", 1920 div 2, 1080 div 2, 4)
fixedSize(true)
integerScale(true)

var
  astroPal = loadPaletteFromGPL("pal/astroships.gpl")
  explosion: Explosion

var control: Controller = newController()

proc gameInit() =
  setPalette(astroPal)
  explosion = newExplosion(32, 15)

  control.debug = true
  control.debugFontScale = 4

proc gameUpdate(dt: float32) =
  control.update(dt)

  if control.accelerate:
    explosion.x = explosion.x + (dt * 30)

  explosion.update(dt)

proc gameDraw() =
  cls()
  explosion.render()
  control.render()

nico.run(gameInit, gameUpdate, gameDraw)