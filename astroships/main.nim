import nico, objects/explosion as exp, api/controller as ctrl

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

var control: Controller

proc gameInit() =

  # Create game controller
  control = newController()

  # Load sprites
  loadSpritesheet(sprExplosion, "sprites/explosion.png", 32, 32)
  loadSpritesheet(sprShip, "sprites/ship.png", 16, 16)
  setPalette(astroPal)

  explosion = newExplosion()

proc gameUpdate(dt: float32) =
  frame += 1
  buttonDown = btn(pcA)

  explosion.update(dt)
  control.update(dt)


proc gameDraw() =
  cls()

  ## Mouse down
  setColor(1)
  print("mouse down:", 10, 10)
  case control.mouse.down:
  of true:
    setColor(10)
    print("true", 80, 10)
  of false:
    setColor(2)
    print("false", 80, 10)

  ## Mouse up
  setColor(1)
  print("mouse up:", 10, 20)
  case control.mouse.up:
  of true:
    setColor(10)
    print("true", 80, 20)
  of false:
    setColor(2)
    print("false", 80, 20)

  ## Mouse just down
  setColor(1)
  print("mouse justdown:", 10, 30)
  case control.mouse.justdown:
  of true:
    setColor(10)
    print("true", 80, 30)
  of false:
    setColor(2)
    print("false", 80, 30)

  ## Mouse X Coordinate
  setColor(1)
  print("mouse x:", 10, 40)
  print($control.mouse.x, 80, 40)

  ## Mouse Y Coordinate
  setColor(1)
  print("mouse y:", 10, 50)
  print($control.mouse.y, 80, 50)

  ## Mouse X Coordinate
  setColor(1)
  print("mouse relX:", 10, 60)
  print($control.mouse.relX, 80, 60)

  ## Mouse Y Coordinate
  setColor(1)
  print("mouse relY:", 10, 70)
  print($control.mouse.relY, 80, 70)

  ## Accelerating
  setColor(1)
  print("Engine:", 10, 80)
  case control.accelerate:
  of true:
    setColor(10)
    print("true", 80, 80)
  of false:
    setColor(2)
    print("false", 80, 80)




nico.run(gameInit, gameUpdate, gameDraw)