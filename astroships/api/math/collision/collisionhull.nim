import 
  ../vector2,
  ../circle,
  ../polygon

type 
  CollisionHullKind* = enum
    chkCirle
    chkPolygon

  CollisionHull* = ref object
    case kind: CollisionHullKind
    of chkCirle:
      circle: Circle
    of chkPolygon:
      polygon: Polygon

proc newPolygonCollisionHull*(polygon: Polygon): CollisionHull =
  CollisionHull(kind: chkPolygon, polygon: polygon)

proc newCircleCollisionHull*(circle: Circle): CollisionHull =
  CollisionHull(kind: chkCirle, circle: circle)

proc getCircleToCircleProjectionAxes(circleA, circleB: Circle, aToB: Vector2): seq[Vector2] =
  result.add(
    (circleB.getCenter() - circleA.getCenter() + aToB)
    .normalize()
  )

proc getPolygonProjectionAxes(poly: Polygon): seq[Vector2] =
  ## Fills an array with the projection axes of the PolygonCollisionHull facing away from the hull.
  ## @param poly the Polygon of the PolygonCollisionHull.
  ## @returns The array of axes facing away from the hull.
  let clockwise = poly.isClockwise()
  var
    i = 0
    j = 1
  while i < poly.len:
    let
      nextPoint = if j == poly.len: poly[0] else: poly[j]
      currentPoint = poly[i]
      edge = nextPoint - currentPoint
    if edge.getMagnitude() == 0f:
        continue
    let axis: Vector2 = edge.perpendicular().normalize()
    result.add(if clockwise: axis.negate() else: axis)
    i.inc
    j.inc

proc getCircleToPolygonProjectionAxes(
  circle: Circle,
  poly: Polygon,
  circleToPoly: Vector2
): seq[Vector2] =
  let circleCenter = circle.getCenter()
  for i in 0..poly.len:
      result.add(
        ((poly[i] - circleCenter) - circleToPoly).normalize()
      )

proc getProjectionAxes*(
  this: CollisionHull,
  otherHull: CollisionHull,
  toOther: Vector2
): seq[Vector2] =
  ## Generates projection axes facing away from this hull towards the given other hull.
  ## @param toOther A vector from this hull's reference frame to the other hull's reference frame.
  ## @param otherHull The collision hull being tested against.
  ## @return The array of axes.
  case this.kind
  of chkCirle:
    case otherHull.kind
    of chkCirle:
      return this.circle.getCircleToCircleProjectionAxes(otherHull.circle, toOther)
    of chkPolygon:
      return this.circle.getCircleToPolygonProjectionAxes(otherHull.polygon, toOther)

  of chkPolygon:
    case otherHull.kind
    of chkCirle:
      return otherHull.circle.getCircleToPolygonProjectionAxes(this.polygon, toOther.negate())
    of chkPolygon:
      return this.polygon.getPolygonProjectionAxes()

