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

  # Title Text
  let titleText = newTextEntity(
      "ASTROSHIPS",
      WINDOW_WIDTH div 2,
      2,
      taCenter,
      textScale,
      1,
      false,
      3
  )
  titleText.addMouseEnterListener(proc = echo "Mouse Enter")
  titleText.addMouseLeaveListener(proc = echo "Mouse Leave")

  result.add(titleText)

  # Menu Options
  let yOffset: float = 160f

  ## New Game
  #[result.add(
    newTextEntity(
      "NEW GAME",
      WINDOW_WIDTH / 2,
      yOffset,
      FONT_HEIGHT,
      taCenter,
      10,
      1,
      false,
      3
    )
  )]#
  ## Options
  #[result.add(
    newTextEntity(
      "OPTIONS",
      WINDOW_WIDTH / 2,
      yOffset + 90,
      FONT_HEIGHT,
      taCenter,
      10,
      1,
      false,
      3
    )
  )]#
  ## ABOUT
  #[result.add(
    newTextEntity(
      "ABOUT",
      WINDOW_WIDTH / 2,
      yOffset + 180,
      FONT_HEIGHT,
      taCenter,
      10,
      1,
      false,
      3
    )
  )]#
