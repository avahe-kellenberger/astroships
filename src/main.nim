import nico

var buttonDown = false

proc gameInit() =
  var pal = loadPaletteFromGPL("palette.gpl")
  loadSpritesheet(1, "sprites/explosion_sheet.png", 32, 32)
  setPalette(pal)

proc gameUpdate(dt: float32) =
  buttonDown = btn(pcA)

proc gameDraw() =
  cls()
  setSpritesheet(1)
  spr(3, 20, 20)

nico.init("nimtendo", "ASTROSHIPS")
nico.createWindow("ASTROSHIPS", 128, 128, 4, false)
nico.run(gameInit, gameUpdate, gameDraw)
