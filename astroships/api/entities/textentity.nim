import nico, nico/utils
import ../entity
import ../math/rectangle
import ../../windowprops

type TextAlign* = enum
  taLeft
  taCenter
  taRight

type TextEntity* = ref object of Entity
  text*: string
  width, height: int
  align*: TextAlign
  scale*: int
  color*: int
  outline*: bool
  outlineColor*: int
  containsMouse*: bool
  mouseEnterListeners: seq[proc: void]
  mouseLeaveListeners: seq[proc: void]

proc newTextEntity*(
  text: string,
  x, y: float,
  align: TextAlign = taLeft,
  scale, color: int = 1,
  outline: bool = false,
  outlineColor: int = 1
): TextEntity =
  result = TextEntity(
    flags: loUpdateRender,
    x: x,
    y: y,
    width: textWidth(text) * scale,
    height: fontHeight() * scale,
    text: text,
    align: align,
    scale: scale,
    color: color,
    outline: outline,
    outlineColor: outlineColor
  )

template width*(this: TextEntity): int = this.width
template height*(this: TextEntity): int = this.height

func containsPoint*(this: TextEntity, x, y: float): bool =
  case this.align:
  of taLeft:
    return containsPoint(this.x, this.y, this.width.float, this.height.float, x, y)
  of taCenter:
    return containsPoint(this.x - this.width/2, this.y, this.width.float, this.height.float, x, y)
  of taRight:
    return containsPoint(this.x - this.width.float, this.y, this.width.float, this.height.float, x, y)



method render*(this: TextEntity) =
  #echo "X: " & $this.x & " Y: " & $this.y
  setColor(this.color)
  setOutlineColor(this.outlineColor)
  case this.align:
  of taLeft:
    print(this.text, this.x, this.y, this.scale)
    if this.outline:
      printOutline(this.text, this.x, this.y, this.scale)
  of taCenter:
    printc(this.text, this.x, this.y, this.scale)
    if this.outline:
      printOutlineC(this.text, this.x, this.y, this.scale)
  of taRight:
    printr(this.text, this.x, this.y, this.scale)
    if this.outline:
      printOutlineR(this.text, this.x, this.y, this.scale)

proc addMouseLeaveListener*(this: TextEntity, listener: proc()) =
  this.mouseLeaveListeners.add(listener)
proc addMouseEnterListener*(this: TextEntity, listener: proc()) =
  this.mouseEnterListeners.add(listener)

proc onMouseLeave*(this: TextEntity) =
  for listener in this.mouseLeaveListeners:
    listener()

proc onMouseEnter*(this: TextEntity) =
  for listener in this.mouseEnterListeners:
    listener()

method update*(this: TextEntity, deltaTime: float) =
  let mouseCoord = mouse()
  let doesContainMouse = this.containsPoint(mouseCoord[0].float, mouseCoord[1].float)
  if this.containsMouse != doesContainMouse:
    this.containsMouse = doesContainMouse
    if this.containsMouse:
      this.onMouseEnter()
    else:
      this.onMouseLeave()

