import nico

proc printText*(text: string, x,y: Pint, scale: Pint = 1, adjust: seq[char]) =
  var x = x - cameraX
  var y = y - cameraY


  for char in text:
    x += glyph(char, x, y, scale)
    if adjust.contains(char):
        x -= scale