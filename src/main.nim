import nico

var buttonDown = false
var frame = 0

proc gameInit() =
  return

proc explosion() =
  setSpritesheet(2)
  palt(14, true)
  spr(0 + ((frame.float / 5.0).int mod 11), 20, 20)

proc gameUpdate(dt: float32) =
  frame += 1
  buttonDown = btn(pcA)

proc gameDraw() =
  cls()

  setColor(1)
  print("click for explosion!", 10, 10)

  if mousebtn(0):
    explosion()
  

nico.init("nico", "ASTROSHIPS")
nico.createWindow("ASTROSHIPS", 128, 128, 4)

# For now lets just get the explosion palette working
setPalette(loadPaletteFromGPL("explosion.gpl"))

loadSpritesheet(2, "sprites/explosion_sheet.png", 32, 32)
fixedSize(true)
integerScale(true)

nico.run(gameInit, gameUpdate, gameDraw)
