import nico
import vector2

type Circle* = ref object
  center: Vector2
  radius: float

proc newCircle*(center: Vector2, radius: float): Circle =
  Circle(
    center: center,
    radius: radius
  )

proc newCircle*(centerX, centerY, radius: float): Circle =
  return newCircle(newVector2(centerX, centerY), radius)

template getCenter*(this: Circle): Vector2 = this.center
template getRadius*(this: Circle): float = this.radius

func project*(this: Circle, location, axis: Vector2): Vector2 =
  let 
    newLoc = this.center + location
    centerDot = axis.dotProduct(newLoc)
  return newVector2(centerDot - this.radius, centerDot + this.radius)

proc render*(this: Circle, offset: Vector2 = VectorZero) =
  circ(offset.x + this.center.x, offset.y + this.center.y, this.radius)

