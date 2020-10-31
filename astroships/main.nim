import random
import nico
import api/scene, api/layer
import scenes/titlescene/titlescene

# Random is used in different modules,
# and needs to be initialized globally.
randomize()

# Nico Config
nico.init("nico", "ASTROSHIPS")
nico.createWindow("ASTROSHIPS", 1920 div 2, 1080 div 2, 4)
fixedSize(true)
integerScale(true)

## Load Palette
var astroPal = loadPaletteFromGPL("pal/astroships.gpl")

## Create Scene
var currentScene: Scene

# Init Game
proc gameInit() =
  setPalette(astroPal)

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
  currentScene.render()

# Run Game
nico.run(gameInit, gameUpdate, gameDraw)