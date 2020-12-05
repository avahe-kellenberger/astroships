import nico
import
  ../../api,
  ../../api/layer,
  ../../colors,
  ../../dimensions,
  ../../api/entities/textentity,
  ../../api/entities/sliderentity
  


type OptionsLayer* = ref object of Layer
    header: TextEntity
    menu: seq[TextEntity]
    itemBack: TextEntity
    optionA: SliderEntity

proc newOptionsLayer*: OptionsLayer = 
  result = OptionsLayer()
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

  # Menu Options
  let yOffset: float = 180f

  ## New Game
  var subtitleText = newTextEntity(
      "OPTIONS",
      windowWidth / 2,
      yOffset,
      taCenter,
      menuScale,
      ncWhite,
      false,
      3
    )
  result.add(subtitleText)

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

  let optionA = newSliderEntity(int(windowWidth/2), 200, 300, 36, 0, 100, 50)
  result.add(optionA)
  result.optionA = optionA


proc addBackClickedListener*(this: OptionsLayer, listener: proc()) =
  this.itemBack.addMouseClickListener(listener)