import nico
import
  ../../api,
  ../../api/layer,
  ../../api/entities/textentity

const
  windowWidth = 640
  windowHeight = 480

type AboutLayer* = ref object of Layer
    header: TextEntity
    menu: seq[TextEntity]

proc newAboutLayer*: AboutLayer = 
  result = AboutLayer()
  let textScale: Pint = 8
  let menuScale: Pint = 4

  # Title Text
  let titleText = newTextEntity(
      "ASTROSHIPS",
      windowWidth div 2,
      40,
      taCenter,
      textScale,
      1,
      false,
      3
  )
  result.add(titleText)

  let yOffset: float = 180f

  ## SubTitle
  var subtitleText = newTextEntity(
      "ABOUT",
      windowWidth / 2,
      yOffset,
      taCenter,
      menuScale,
      1,
      false,
      3
    )
  result.add(subtitleText)