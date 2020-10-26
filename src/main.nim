import nico, sdl2/sdl

nico.init("nico", "ASTROSHIPS")
nico.createWindow("ASTROSHIPS", 128, 128, 4)
fixedSize(true)
integerScale(true)

var buttonDown = false
var frame = 0

## Sprite Aliases
var sprExplosion = 2;
var sprShip = 3;

# Load Palettes (pal)
var explosionPalette = loadPaletteFromGPL("pal/explosion.gpl")
var shipPalette = loadPaletteFromGPL("pal/ship.gpl")

proc gameInit() =
  # Load sprites
  loadSpritesheet(sprExplosion, "sprites/explosion_sheet.png", 32, 32)
  loadSpritesheet(sprShip, "sprites/ship_sheet.png", 16, 16)
  return

proc drawExplosion() =
  setPalette(explosionPalette)
  palt(14, true)
  setSpritesheet(sprExplosion)
  spr(0 + ((frame.float / 5).int mod 11), 20, 20)

proc drawShip() =
  setPalette(shipPalette)
  palt(9, true)
  setSpritesheet(sprShip)
  spr(0 + ((frame.float / 15).int mod 3), 60, 60)

proc gameUpdate(dt: float32) =
  frame += 1
  buttonDown = btn(pcA)

proc gameDraw() =
  cls()

  setColor(7)
  print("click for explosion!", 10, 10)
  
  drawExplosion()
  drawShip()

nico.run(gameInit, gameUpdate, gameDraw)