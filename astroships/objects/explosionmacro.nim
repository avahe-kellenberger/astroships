import macros

# dumpTree:
#   createAnimation:
#     Explosion("explosion.png", 32, 32):
#       result.addAnimation(Explode, explodeAnimation)
#       result.setAnimation(Explode)

# StmtList
#   Call
#     Ident "createAnimation"
#     StmtList
#       Call
#         Ident "Explosion"
#         StrLit "explosion.png"
#         IntLit 32
#         IntLit 32
#         StmtList
#           Call
#             DotExpr
#               Ident "result"
#               Ident "addAnimation"
#             Ident "Explode"
#             Ident "explodeAnimation"
#           Call
#             DotExpr
#               Ident "result"
#               Ident "setAnimation"
#             Ident "Explode"

# const
#   spritesheet = "explosion.png"
#   width = 32
#   height = 32

# var spritesheetIndex = -1

# type Explosion* = ref object of AnimatedEntity

# proc newExplosion*(x, y: int = 0): Explosion =
#   # Lazy init our spritesheetIndex because nico needs to load first.
#   if spritesheetIndex < 0:
#     spritesheetIndex = loadSpritesheet(spritesheet, width, height)
#   result =
#     Explosion(
#       spritesheetIndex: spritesheetIndex,
#       x: x.float,
#       y: y.float
#     )
#   result.width = width
#   result.height = height

#   # Add any animations we need.
#   result.addAnimation(Explode, explodeAnimation)

#   # Be sure to set the animation when finished.
#   result.setAnimation(Explode)

macro createAnimation(body) =
  # Find the spritesheet, width, and height.
  let spritesheetName = body[0][1]
  if spritesheetName.kind != nnkStrLit:
    raise newException(Exception, $spritesheetName & " is not a string!")

  let width = body[0][2]
  if width.kind != nnkIntLit:
    raise newException(Exception, $width & " is not an int!")

  let height = body[0][3]
  if height.kind != nnkIntLit:
    raise newException(Exception, $height & " is not an int!")

  let consts = quote do:
    const
      spritesheet = `spritesheetName`
      width = `width`
      height = `height`
    
    var spritesheetIndex = -1

    type `animType`* = ref object of AnimatedEntity

  # var consts = newNimNode(nnkConstSection)
  # consts.add(
  #   newNimNode(nnkConstDef).add(
  #     newIdentNode("spritesheet"),
  #     newNimNode(nnkEmpty),
  #     spritesheetName
  #   )
  # )

  result = newStmtList()
  result.add(consts)


  echo result.repr

createAnimation:
  Explosion("explosion.png", 32, 32):
    result.addAnimation(Explode, explodeAnimation)
    result.setAnimation(Explode)

# StmtList
#   ConstSection
#     ConstDef
#       Ident "spritesheet"
#       Empty
#       StrLit "explosion.png"
#     ConstDef
#       Ident "width"
#       Empty
#       IntLit 32
#     ConstDef
#       Ident "height"
#       Empty
#       IntLit 32
#   VarSection
#     IdentDefs
#       Ident "spritesheetIndex"
#       Empty
#       Prefix
#         Ident "-"
#         IntLit 1
#   TypeSection
#     TypeDef
#       Postfix
#         Ident "*"
#         Ident "Explosion"
#       Empty
#       RefTy
#         ObjectTy
#           Empty
#           OfInherit
#             Ident "AnimatedEntity"
#           Empty
#   ProcDef
#     Postfix
#       Ident "*"
#       Ident "newExplosion"
#     Empty
#     Empty
#     FormalParams
#       Ident "Explosion"
#       IdentDefs
#         Ident "x"
#         Ident "y"
#         Ident "int"
#         IntLit 0
#     Empty
#     Empty
#     StmtList
#       IfStmt
#         ElifBranch
#           Infix
#             Ident "<"
#             Ident "spritesheetIndex"
#             IntLit 0
#           StmtList
#             Asgn
#               Ident "spritesheetIndex"
#               Call
#                 Ident "loadSpritesheet"
#                 Ident "spritesheet"
#                 Ident "width"
#                 Ident "height"
#       Asgn
#         Ident "result"
#         ObjConstr
#           Ident "Explosion"
#           ExprColonExpr
#             Ident "spritesheetIndex"
#             Ident "spritesheetIndex"
#           ExprColonExpr
#             Ident "x"
#             DotExpr
#               Ident "x"
#               Ident "float"
#           ExprColonExpr
#             Ident "y"
#             DotExpr
#               Ident "y"
#               Ident "float"
#       Asgn
#         DotExpr
#           Ident "result"
#           Ident "width"
#         Ident "width"
#       Asgn
#         DotExpr
#           Ident "result"
#           Ident "height"
#         Ident "height"
#       Call
#         DotExpr
#           Ident "result"
#           Ident "addAnimation"
#         Ident "Explode"
#         Ident "explodeAnimation"
#       Call
#         DotExpr
#           Ident "result"
#           Ident "setAnimation"
#         Ident "Explode"
