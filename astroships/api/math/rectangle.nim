type 
  Rectangle* = ref object
    x, y, width, height: float

proc newRectangle*(x, y, width, height: float): Rectangle =
  Rectangle(
    x: x,
    y: y,
    width: width,
    height: height
  )

