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
    thrustKey*: int
    thrust*: int
    mouse*: Mouse

proc newController*(): Controller =
    result = Controller()
    var mouse: Mouse = Mouse(down: false, up: false, justDown: false)
    result.mouse = mouse
    result.thrust = 0
    result.thrustKey = 0

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

proc update*(this: Controller, deltaTime: float)  =
    this.updateController(deltaTime)

