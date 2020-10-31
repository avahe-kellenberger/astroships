import nico
import ../../api/layer
import ../../api/entities/textentity

type
    TitleLayer* = ref object of Layer
      header: TextEntity

proc newTitleLayer*: TitleLayer = 
  result = TitleLayer()
  var textScale: Pint = 16
  var width = getTextWidth("ASTROSHIPS", textScale)
  ## We need to figure out how to pass in the current canvas width
  ## otherwise center aligning on screen is going to be a pain.
  ## I don't think that the text alignment procedures are relative
  ## to the actual viewport.
  result.add(newTextEntity("ASTROSHIPS",((1920 / (textScale / 2)) / 2) + float(width) / (textScale / 2), 2f, alnLeft, textScale, 1))