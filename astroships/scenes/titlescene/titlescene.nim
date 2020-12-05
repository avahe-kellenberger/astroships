import ../../api/scene
import ./titlelayer
import ./optionslayer
import ./aboutlayer

type
    TitleSceneMenu* = enum
        tsmNewGame
        tsmOptions
        tsmAbout
    TitleScene* = ref object of Scene
        menu*: TitleSceneMenu
        titleLayer: TitleLayer
        optionsLayer: OptionsLayer
        aboutLayer: AboutLayer
  

proc newTitleScene*: TitleScene = 
  result = TitleScene(
      isLayerOrderValid: true,
      menu: tsmNewGame,
      titleLayer: newTitleLayer(),
      optionsLayer: newOptionsLayer(),
      aboutLayer: newAboutLayer()
  )

  let foo = result
  result.titleLayer.addOptionsClickedListener(
      proc =
          foo.removeAllLayers()
          foo.addLayer(foo.optionsLayer)
  )
  result.titleLayer.addAboutClickedListener(
      proc =
          foo.removeAllLayers()
          foo.addLayer(foo.aboutLayer)
  )

  ## Back Listeners
  result.aboutLayer.addBackClickedListener(
      proc =
          foo.removeAllLayers()
          foo.addLayer(foo.titleLayer)
  )
  result.optionsLayer.addBackClickedListener(
      proc =
          foo.removeAllLayers()
          foo.addLayer(foo.titleLayer)
  )

  result.addLayer(result.titleLayer)