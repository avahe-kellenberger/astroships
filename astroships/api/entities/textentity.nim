import nico
import ../entity

type TextAlign* = enum
    alnLeft
    alnCenter
    alnRight

type TextEntity* = ref object of Entity
    text*: string
    align*: TextAlign
    scale*: int
    color*: int

proc newTextEntity*(text: string, x, y: float = 0f, align: TextAlign, scale, color: int = 1): TextEntity =
  result = TextEntity(
    flags: loRender,
    x: x,
    y: y
  )
  result.text = text
  result.align = align
  result.scale = scale
  result.color = color

method render*(this: TextEntity) =
    setColor(this.color)
    case this.align:
    of alnLeft:
        print(this.text, this.x, this.y, this.scale)
    of alnCenter:
        printc(this.text, this.x, this.y, this.scale)
    of alnRight:
        printr(this.text, this.x, this.y, this.scale)

proc getTextWidth*(text: string, scale: Pint): Pint =
    result = textWidth(text, scale)