import nico

import math/vector2

type
  Mouse* = ref object
    location*: Vector2
    isPressed*: bool
    justPressed*: bool

  Controller* = ref object of RootObj
    accelerating*: bool
    accelerateKey*: Keycode
    mouse*: Mouse
    debug*: bool
    debugFontScale*: Positive

proc newController*(): Controller =
  Controller(
    mouse: Mouse(),
    accelerating: false,
    accelerateKey: Keycode(K_w),
    debugFontScale: 1
  )

proc update*(this: Controller, deltaTime: float) =
  # Mouse Coordinates
  this.mouse.location = toVector2(mouse())

  # Mouse Button
  this.mouse.isPressed = mousebtn(0)
  this.mouse.justPressed = mousebtnp(0)

  # Acceleration Key
  this.accelerating = key(this.accelerateKey)

proc debugPrint*(this: Controller, text: string, x: int, y: int) =
  print(
    text,
    x * this.debugFontScale.Pint,
    y * this.debugFontScale.Pint,
    this.debugFontScale.Pint
  )

proc render*(this: Controller) =
  if not this.debug:
    return

  ## Mouse down
  setColor(1)
  this.debugPrint("mouse down:", 10, 20)
  if this.mouse.isPressed:
    setColor(10)
    this.debugPrint("true", 80, 20)
  else:
    setColor(2)
    this.debugPrint("false", 80, 20)

  ## Mouse just down
  setColor(1)
  this.debugPrint("mouse just down:", 10, 30)
  case this.mouse.justPressed:
  of true:
    setColor(10)
    this.debugPrint("true", 80, 30)
  of false:
    setColor(2)
    this.debugPrint("false", 80, 30)

  setColor(1)
  ## Mouse X Coordinate
  this.debugPrint("mouse x:", 10, 40)
  this.debugPrint($this.mouse.location.x, 80, 40)

  ## Mouse Y Coordinate
  this.debugPrint("mouse y:", 10, 50)
  this.debugPrint($this.mouse.location.y, 80, 50)

  ## Accelerating
  this.debugPrint("accelerating:", 10, 60)
  case this.accelerating:
  of true:
    setColor(10)
    this.debugPrint("true", 80, 60)
  of false:
    setColor(2)
    this.debugPrint("false", 80, 60)
