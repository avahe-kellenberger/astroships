type 
  Rectangle* = ref object
    x*, y*, width*, height*: float

proc newRectangle*(x, y, width, height: float): Rectangle =
  Rectangle(
    x: x,
    y: y,
    width: width,
    height: height
  )

proc containsPoint*(x, y, width, height, pointX, pointY: float): bool =
  return
    pointX >= x and
    pointX < x + width and
    pointY >= y and
    pointY < y + height

