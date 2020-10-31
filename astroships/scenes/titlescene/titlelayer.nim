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
  ## We need to figure out how to pass in the current canvas width
  ## otherwise center aligning on screen is going to be a pain.
  ## I don't think that the text alignment procedures are relative
  ## to the actual viewport.
  result.add(
    newTextEntity(
      "ASTROSHIPS",
      WINDOW_WIDTH / 2,
      2f,
      taCenter,
      textScale
    )
  )
