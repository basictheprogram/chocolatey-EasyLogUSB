#include <Constants.au3>

Func Install()
   ConsoleWrite("Install EasyLog" & @LF)
   Local $handle = WinGetHandle("EasyLog USB Device Driver Installer")
   ConsoleWrite("Install EasyLog2 " & $handle & @LF)
   Local $click = ControlClick($handle, "", "[CLASS:Button; INSTANCE:1]", "Left", 1)
   ConsoleWrite("Install EasyLog3 " & $click & @LF)
   Local $close = WinClose($handle)
   ConsoleWrite("Closing " & $close & @LF)
EndFunc

#RequireAdmin
Install()
ConsoleWrite("End of Install!" & @LF)
