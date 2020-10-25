# Package

version = "0.0.0"
author = "Avahe Kellenberger"
description = "astroships"
license = "?"

# Deps
requires "nim >= 1.4.0"
requires "nico >= 0.3.2"

srcDir = "src"

task runr, "Runs astroships for current platform":
 exec "nim c -r --multimethods:on -d:release -o:astroships astroships/main.nim"

task rund, "Runs debug astroships for current platform":
 exec "nim c -r --multimethods:on -d:debug -o:astroships astroships/main.nim"

task release, "Builds astroships for current platform":
 exec "nim c --multimethods:on -d:release -o:astroships astroships/main.nim"

task debug, "Builds debug astroships for current platform":
 exec "nim c --multimethods:on -d:debug -o:astroships_debug astroships/main.nim"

task web, "Builds astroships for current web":
 exec "nim js --multimethods:on -d:release -o:astroships.js astroships/main.nim"

task webd, "Builds debug astroships for current web":
 exec "nim js --multimethods:on -d:debug -o:astroships.js astroships/main.nim"

task deps, "Downloads dependencies":
 exec "curl https://www.libsdl.org/release/SDL2-2.0.12-win32-x64.zip -o SDL2_x64.zip"
 exec "unzip SDL2_x64.zip"

task test, "run tests":
  exec "for i in tests/**/*.nim; do nim c -r --multimethods:on \"$i\"; done"

