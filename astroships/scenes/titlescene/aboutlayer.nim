import nico
import
  ../../api,
  ../../api/layer,
  ../../api/entities/textentity,
  ../../colors,
  ../../dimensions

type AboutLayer* = ref object of Layer
    header: TextEntity
    menu: seq[TextEntity]
    itemBack: TextEntity

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
      ncWhite,
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
      ncWhite,
      false,
      3
    )
  result.add(subtitleText)


  ## Info Text
  var infoText = newTextEntity(
      "ASTROSHIPS is a game created by...",
      windowWidth / 2,
      yOffset + 60,
      taCenter,
      2,
      ncWhite,
      false,
      3
    )
  result.add(infoText)

  ## BACK
  let itemBack = newTextEntity(
      "<<<",
      windowWidth / 2,
      yOffset + 180,
      taCenter,
      2,
      ncWhite,
      false,
      3
    )
  result.add(itemBack)
  itemBack.addMouseEnterListener(proc = itemBack.color = ncRed)
  itemBack.addMouseLeaveListener(proc = itemBack.color = ncWhite)
  itemBack.addMouseClickListener(
    proc =
        echo "BACK"
  )
  result.itemBack = itemBack

proc addBackClickedListener*(this: AboutLayer, listener: proc()) =
  this.itemBack.addMouseClickListener(listener)