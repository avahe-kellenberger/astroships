import nico
import random
import sdl2

import
  api,
  objects/explosion as exp,
  objects/player as plyr,
  colors,
  dimensions
import scenes/titlescene/titlescene

# Random is used in different modules,
# and needs to be initialized globally.
randomize()

const
  windowWidth = 640
  windowHeight = 480
  windowScale = 1
  

nico.init("nico", "ASTROSHIPS")
nico.createWindow("ASTROSHIPS", windowWidth, windowHeight, windowScale)
fixedSize(true)
integerScale(true)

var
  astroPal = loadPaletteFromGPL("pal/astroships.gpl")

loadFont(2, "fontfix.png")

setFont(2)

## Create Scene
var currentScene: Scene


proc gameInit() =
  setPalette(astroPal)
  var titleScene: TitleScene
  titleScene = newTitleScene()
  titleScene.menu = tsmNewGame
  

  currentScene = titleScene

proc gameUpdate(dt: float32) =
  currentScene.update(dt)

proc gameDraw() =
  cls()
  setColor(0)
  rectfill(0, 0, windowWidth, windowHeight)
  setColor(1)
  currentScene.render()

nico.run(gameInit, gameUpdate, gameDraw)

