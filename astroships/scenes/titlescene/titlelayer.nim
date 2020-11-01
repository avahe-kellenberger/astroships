import nico
import
  ../../windowprops,
  ../../api/layer,
  ../../api/entities/textentity

type TitleLayer* = ref object of Layer
    header: TextEntity
    menu: seq[TextEntity]

proc newTitleLayer*: TitleLayer = 
  result = TitleLayer()
  let textScale: Pint = 8
  let menuScale: Pint = 4

  # Title Text
  let titleText = newTextEntity(
      "ASTROSHIPS",
      WINDOW_WIDTH div 2,
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
  var itemNewGame = newTextEntity(
      "NEW GAME",
      WINDOW_WIDTH / 2,
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


  ## Options
  var itemOptions = newTextEntity(
      "OPTIONS",
      WINDOW_WIDTH / 2,
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

  ## ABOUT
  var itemAbout = newTextEntity(
      "ABOUT",
      WINDOW_WIDTH / 2,
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
