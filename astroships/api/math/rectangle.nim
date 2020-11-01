import vector2

type 
  Rectangle* = ref RectangleObj
  RectangleObj* = object
    x, y, width, height: float
    topLeft, center, bottomRight: Vector2

proc newRectangle*(x, y, width, height: float): Rectangle =
  result = Rectangle(
    x: x,
    y: y,
    width: width,
    height: height
  )
  result.topLeft = newVector2(result.x, result.y)
  result.center = newVector2(
    result.x + result.width / 2,
    result.y + result.height / 2
  )
  result.bottomRight = newVector2(
    result.x + result.width,
    result.y + result.height
  )

template x*(this: Rectangle): float = this.x
template y*(this: Rectangle): float = this.y
template width*(this: Rectangle): float = this.width
template height*(this: Rectangle): float = this.height

template topLeft*(this: Rectangle): Vector2 = this.topLeft
template center*(this: Rectangle): Vector2 = this.center
template bottomRight*(this: Rectangle): Vector2 = this.bottomRight

