
import mantle
import windows

import "../common/window_base.nim"

registerWindowClass()
buildWindow(1440, 900)

while true:
  pollWindow()
