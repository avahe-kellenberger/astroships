import nico
import random
import 
  windowprops,
  api/[scene, layer, printfix],
  scenes/titlescene/titlescene

# Random is used in different modules,
# and needs to be initialized globally.
randomize()

# Nico Config
nico.init("nico", "ASTROSHIPS")
nico.createWindow("ASTROSHIPS", WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_SCALE, WINDOW_FULLSCREEN)
fixedSize(true)
integerScale(true)

loadFont(2, "fontfix.png")

## Load Palette
var astroPal = loadPaletteFromGPL("pal/astroships.gpl")

## Create Scene
var currentScene: Scene

# Init Game
proc gameInit() =
  setPalette(astroPal)
  setFont(2)
  var titleScene: TitleScene
  titleScene = newTitleScene()
  titleScene.menu = tsmNewGame

  currentScene = titleScene

# Update Game
proc gameUpdate(dt: float32) =
  currentScene.update(dt)

# Draw Game
proc gameDraw() =
  cls()
  setColor(8)
  rectFill(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)

  setColor(1)
  currentScene.render()

# Run Game
nico.run(gameInit, gameUpdate, gameDraw)
