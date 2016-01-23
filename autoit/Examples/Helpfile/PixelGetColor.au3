#include <MsgBoxConstants.au3>

Local $iColor = PixelGetColor(10, 100)

MsgBox($MB_SYSTEMMODAL, "", "The decimal color is: " & $iColor)
MsgBox($MB_SYSTEMMODAL, "", "The hex color is: " & Hex($iColor, 6))
