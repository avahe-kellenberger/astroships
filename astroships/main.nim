import nico, objects/explosion as exp

nico.init("nico", "ASTROSHIPS")
nico.createWindow("ASTROSHIPS", 128, 128, 4)
fixedSize(true)
integerScale(true)

var buttonDown = false
var frame = 0

## Sprite Aliases
var sprExplosion = 0;
var sprShip = 1;

var astroPal = loadPaletteFromGPL("pal/astroships.gpl")


var explosion: Explosion

proc gameInit() =
  # Load sprites
  loadSpritesheet(sprExplosion, "sprites/explosion.png", 32, 32)
  loadSpritesheet(sprShip, "sprites/ship.png", 16, 16)
  setPalette(astroPal)

  explosion = newExplosion()

proc gameUpdate(dt: float32) =
  frame += 1
  buttonDown = btn(pcA)

  explosion.update(dt)

proc gameDraw() =
  cls()

  setColor(1)
  print("click for explosion!", 10, 10)

  explosion.render()

  if (mousebtnp(0)):
    explosion.resetAnimation()


nico.run(gameInit, gameUpdate, gameDraw)