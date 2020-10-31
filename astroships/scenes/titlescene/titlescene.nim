import ../../api/scene
import ./titlelayer

type
    TitleSceneMenu* = enum
        tsmNewGame
        tsmOptions
        tsmAbout
    TitleScene* = ref object of Scene
        menu*: TitleSceneMenu

proc newTitleScene*: TitleScene = 
  result = TitleScene(
      isLayerOrderValid: true,
      menu: tsmNewGame
  )
  result.addLayer(newTitleLayer())