import
  sequtils

import
  vector2

type Polygon* = ref object
  verticies: seq[Vector2]

proc newPolygon*(verticies: openArray[Vector2]): Polygon =
  Polygon(verticies: verticies.toSeq())

