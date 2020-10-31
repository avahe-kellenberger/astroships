import nico
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

proc newTextEntity*(
  text: string,
  x, y: float,
  align: TextAlign = taLeft,
  scale, color: int = 1
): TextEntity =
  result = TextEntity(
    flags: loRender,
    x: x,
    y: y,
    text: text,
    align: align,
    scale: scale,
    color: color,
    textWidth: textWidth(text)
  )

template getTextWidth*(this: TextEntity): int = this.textWidth

method render*(this: TextEntity) =
  setColor(this.color)
  case this.align:
  of taLeft:
    print(this.text, this.x, this.y, this.scale)
  of taCenter:
    printc(this.text, this.x, this.y, this.scale)
  of taRight:
    printr(this.text, this.x, this.y, this.scale)

