import nico

type
  Mouse* = ref object
    x*: int
    y*: int
    relX*: float32
    relY*: float32
    down*: bool
    up*: bool
    justDown*: bool

  Controller* = ref object of RootObj
    accelerate*: bool
    accelerateKey*: Keycode
    mouse*: Mouse
    debug*: bool
    debugFontScale*: int

proc newController*(): Controller =
  result = Controller()
  var mouse: Mouse = Mouse(down: false, up: false, justDown: false)
  result.mouse = mouse
  result.accelerate = false
  result.accelerateKey = Keycode(K_W)
  result.debugFontScale = 1

proc setAccelerateKey*(this: Controller, key: Keycode) =
  this.accelerateKey = key

proc update*(this: Controller, deltaTime: float) =
  var m: (int, int) = mouse()
  var mr: (float32, float32) = mouserel()

  # Mouse X/Y Coordinates
  this.mouse.x = m[0]
  this.mouse.y = m[1]

  # Relative Mouse X/Y Coordinates
  this.mouse.relX = mr[0]
  this.mouse.relY = mr[1]

  # Mouse Button
  this.mouse.down = (mousebtn(0) == true)
  this.mouse.up = (mousebtn(0) == false)
  this.mouse.justDown = mousebtnp(0)

  # Acceleration Key
  this.accelerate = key(this.accelerateKey)

proc debugPrint*(this: Controller, text: string, x: int, y: int) =
  print(text, x * this.debugFontScale, y * this.debugFontScale, this.debugFontScale)

proc render*(this: Controller) =
  if not this.debug:
    return

  ## Mouse down
  setColor(1)
  this.debugPrint("mouse down:", 10, 10)
  case this.mouse.down:
  of true:
    setColor(10)
    this.debugPrint("true", 80, 10)
  of false:
    setColor(2)
    this.debugPrint("false", 80, 10)

  ## Mouse up
  setColor(1)
  this.debugPrint("mouse up:", 10, 20)
  case this.mouse.up:
  of true:
    setColor(10)
    this.debugPrint("true", 80, 20)
  of false:
    setColor(2)
    this.debugPrint("false", 80, 20)

  ## Mouse just down
  setColor(1)
  this.debugPrint("mouse justdown:", 10, 30)
  case this.mouse.justdown:
  of true:
    setColor(10)
    this.debugPrint("true", 80, 30)
  of false:
    setColor(2)
    this.debugPrint("false", 80, 30)

  setColor(1)
  ## Mouse X Coordinate
  this.debugPrint("mouse x:", 10, 40)
  this.debugPrint($this.mouse.x, 80, 40)

  ## Mouse Y Coordinate
  this.debugPrint("mouse y:", 10, 50)
  this.debugPrint($this.mouse.y, 80, 50)

  ## Accelerating
  this.debugPrint("Engine:", 10, 60)
  case this.accelerate:
  of true:
    setColor(10)
    this.debugPrint("true", 80, 60)
  of false:
    setColor(2)
    this.debugPrint("false", 80, 60)