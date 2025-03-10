# Package

version       = "0.1.0"
author        = "h00k86"
description   = "elf framework"
license       = "MIT"
srcDir        = "."
bin           = @["main"]


# Dependencies

requires "nim >= 2.0.8"



task buildproject, "compile the porject":
 exec "nim c --out:./build/evil-elf main.nim"

task clear,"clear everything in build":
 exec "rm -rf ./build/*"

