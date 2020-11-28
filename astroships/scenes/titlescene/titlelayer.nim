import nico
import
  ../../api/layer,
  ../../api/entities/textentity

const
  windowWidth = 640
  windowHeight = 480

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
      1,
      false,
      3
  )
  result.add(titleText)

  # Menu Options
  let yOffset: float = 180f

  ## New Game
  let itemNewGame = newTextEntity(
      "NEW GAME",
      windowWidth / 2,
      yOffset,
      taCenter,
      menuScale,
      1,
      false,
      3
    )
  result.add(itemNewGame)
  itemNewGame.addMouseEnterListener(proc = itemNewGame.color = 3)
  itemNewGame.addMouseLeaveListener(proc = itemNewGame.color = 1)
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
      1,
      false,
      3
    )
  result.add(itemOptions)
  itemOptions.addMouseEnterListener(proc = itemOptions.color = 3)
  itemOptions.addMouseLeaveListener(proc = itemOptions.color = 1)
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
      1,
      false,
      3
    )
  result.add(itemAbout)
  itemAbout.addMouseEnterListener(proc = itemAbout.color = 3)
  itemAbout.addMouseLeaveListener(proc = itemAbout.color = 1)
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