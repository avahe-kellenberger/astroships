# Package

version = "0.0.0"
author = "Avahe Kellenberger"
description = "astroships"
license = "?"

# Deps
requires "nim >= 1.2.6"
requires "nico >= 0.3.1"

srcDir = "src"

task runr, "Runs astroships for current platform":
 exec "nim c -r -d:release -o:astroships src/main.nim"

task rund, "Runs debug astroships for current platform":
 exec "nim c -r -d:debug -o:astroships src/main.nim"

task release, "Builds astroships for current platform":
 exec "nim c -d:release -o:astroships src/main.nim"

task debug, "Builds debug astroships for current platform":
 exec "nim c -d:debug -o:astroships_debug src/main.nim"

task web, "Builds astroships for current web":
 exec "nim js -d:release -o:astroships.js src/main.nim"

task webd, "Builds debug astroships for current web":
 exec "nim js -d:debug -o:astroships.js src/main.nim"

task deps, "Downloads dependencies":
 exec "curl https://www.libsdl.org/release/SDL2-2.0.12-win32-x64.zip -o SDL2_x64.zip"
 exec "unzip SDL2_x64.zip"

