import nico
import
  ../../windowprops,
  ../../api/layer,
  ../../api/entities/textentity

type TitleLayer* = ref object of Layer
    header: TextEntity

proc newTitleLayer*: TitleLayer = 
  result = TitleLayer()
  let textScale: Pint = 16
  result.add(
    newTextEntity(
      "ASTROSHIPS",
      WINDOW_WIDTH / 2,
      2f,
      taCenter,
      textScale,
      1,
      false,
      3
    )
  )
