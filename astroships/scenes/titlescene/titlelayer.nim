import nico
import
  ../../api/layer,
  ../../api/entities/textentity,
  ../../colors,
  ../../dimensions

type TitleLayer* = ref object of Layer
    header: TextEntity
    itemNewGame: TextEntity
    itemOptions: TextEntity
    itemAbout: TextEntity

proc newTitleLayer*: TitleLayer = 
  result = TitleLayer()
  
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
  let itemNewGame = newTextEntity(
      "PLAY",
      windowWidth / 2,
      yOffset,
      taCenter,
      menuScale,
      ncWhite,
      false,
      3
    )
  result.add(itemNewGame)
  itemNewGame.addMouseEnterListener(proc = itemNewGame.color = ncRed)
  itemNewGame.addMouseLeaveListener(proc = itemNewGame.color = ncWhite)
  itemNewGame.addMouseClickListener(
    proc =
        echo "NEW GAME"
  )
  result.itemNewGame = itemNewGame

  ## Options
  let itemOptions = newTextEntity(
      "OPTIONS",
      windowWidth / 2,
      yOffset + 90,
      taCenter,
      menuScale,
      ncWhite,
      false,
      3
    )
  result.add(itemOptions)
  itemOptions.addMouseEnterListener(proc = itemOptions.color = ncRed)
  itemOptions.addMouseLeaveListener(proc = itemOptions.color = ncWhite)
  itemOptions.addMouseClickListener(
    proc =
        echo "OPTIONS"
  )
  result.itemOptions = itemOptions

  ## ABOUT
  let itemAbout = newTextEntity(
      "ABOUT",
      windowWidth / 2,
      yOffset + 180,
      taCenter,
      menuScale,
      ncWhite,
      false,
      3
    )
  result.add(itemAbout)
  itemAbout.addMouseEnterListener(proc = itemAbout.color = ncRed)
  itemAbout.addMouseLeaveListener(proc = itemAbout.color = ncWhite)
  itemAbout.addMouseClickListener(
    proc =
        echo "ABOUT"
  )
  result.itemAbout = itemAbout

## Item Clicked Listeners
proc addNewGameClickedListener*(this: TitleLayer, listener: proc()) =
  this.itemNewGame.addMouseClickListener(listener)

proc addOptionsClickedListener*(this: TitleLayer, listener: proc()) =
  this.itemOptions.addMouseClickListener(listener)

proc addAboutClickedListener*(this: TitleLayer, listener: proc()) =
  this.itemAbout.addMouseClickListener(listener)