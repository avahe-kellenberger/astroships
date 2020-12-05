import nico, nico/utils
import ../entity
import ../math/rectangle
import ../../colors


type SliderEntity* = ref object of Entity
  x, y, width, height, min, max, value*: int
  containsMouse*: bool
  mouseEnterListeners: seq[proc: void]
  mouseLeaveListeners: seq[proc: void]
  mouseClickListeners: seq[proc: void]

proc newSliderEntity*(
  x, y, width, height, min, max, value: int,
): SliderEntity =
  result = SliderEntity(
    flags: loUpdateRender,
    width: width,
    height: height,
    min: min,
    max: max,
    value: value
  )

  result.center = initVector2(x, y)

template width*(this: SliderEntity): int = this.width
template height*(this: SliderEntity): int = this.height

func containsPoint*(this: SliderEntity, x, y: float): bool =
  return containsPoint(this.x.float, this.y.float, this.width.float, this.height.float, x, y)



method render*(this: SliderEntity) =
  #echo "X: " & $this.x & " Y: " & $this.y
  setColor(ord(ncGray))
  rectfill(this.center.x - this.width / 2, this.center.y, this.center.x + this.width / 2, this.center.y + this.height)
  setColor(ord(ncDarkGray))
  rectfill((this.center.x - this.width / 2) + 4, this.center.y + 4,( this.center.x + this.width / 2) - 4, (this.center.y + this.height) - 4)
  
  ## Track bar
  setColor(ord(ncGreen))
  var vw = (this.width * this.value) / 100
  rectfill((this.center.x - this.width / 2) + 4, this.center.y + 4, ((this.center.x + this.width / 2) - 4) - vw, (this.center.y + this.height) - 4)


proc addMouseLeaveListener*(this: SliderEntity, listener: proc()) =
  this.mouseLeaveListeners.add(listener)
proc addMouseEnterListener*(this: SliderEntity, listener: proc()) =
  this.mouseEnterListeners.add(listener)
proc addMouseClickListener*(this: SliderEntity, listener: proc()) =
  this.mouseClickListeners.add(listener)

proc onMouseLeave*(this: SliderEntity) =
  for listener in this.mouseLeaveListeners:
    listener()

proc onMouseEnter*(this: SliderEntity) =
  for listener in this.mouseEnterListeners:
    listener()

proc onMouseClick*(this: SliderEntity) =
  for listener in this.mouseClickListeners:
    listener()

method update*(this: SliderEntity, deltaTime: float) =
  let mouseCoord = mouse()
  let doesContainMouse = this.containsPoint(mouseCoord[0].float, mouseCoord[1].float)
  if doesContainMouse and mousebtnp(0):
    this.onMouseClick()
  if this.containsMouse != doesContainMouse:
    this.containsMouse = doesContainMouse
    if this.containsMouse:
      this.onMouseEnter()
    else:
      this.onMouseLeave()

