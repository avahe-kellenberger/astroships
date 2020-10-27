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

proc newController*(): Controller =
    result = Controller()
    var mouse: Mouse = Mouse(down: false, up: false, justDown: false)
    result.mouse = mouse
    result.accelerate = false
    result.accelerateKey = Keycode(K_W)

proc setAccelerateKey*(this: Controller, key: Keycode) =
    this.accelerateKey = key


method updateController*(this: Controller, deltaTime: float) {.base.} =
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

proc update*(this: Controller, deltaTime: float)  =
    this.updateController(deltaTime)

