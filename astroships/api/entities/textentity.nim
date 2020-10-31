import nico, nico/utils
import ../entity

type TextAlign* = enum
  taLeft
  taCenter
  taRight

type TextEntity* = ref object of Entity
  text*: string
  textWidth: int
  align*: TextAlign
  scale*: int
  color*: int
  outline*: bool
  outlineColor*: int

proc newTextEntity*(
  text: string,
  x, y: float,
  align: TextAlign = taLeft,
  scale, color: int = 1,
  outline: bool,
  outlineColor: int = 1
): TextEntity =
  result = TextEntity(
    flags: loRender,
    x: x,
    y: y,
    text: text,
    align: align,
    scale: scale,
    color: color,
    outline: outline,
    outlineColor: outlineColor,
    textWidth: textWidth(text)
  )

template getTextWidth*(this: TextEntity): int = this.textWidth

method render*(this: TextEntity) =
  setColor(this.color)
  setOutlineColor(this.outlineColor)
  case this.align:
  of taLeft:
    print(this.text, this.x, this.y, this.scale)
    if this.outline:
      printOutline(this.text, this.x, this.y, this.scale)
  of taCenter:
    if this.outline:
      printOutlineC(this.text, this.x, this.y, this.scale)
    printc(this.text, this.x, this.y, this.scale)
  of taRight:
    if this.outline:
      printOutlineR(this.text, this.x, this.y, this.scale)
    printr(this.text, this.x, this.y, this.scale)

