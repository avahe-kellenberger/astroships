import
  vector2

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

