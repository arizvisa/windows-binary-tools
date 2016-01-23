#include <MsgBoxConstants.au3>

; Map X drive to \\myserver\stuff using current user
DriveMapAdd("X:", "\\myserver\stuff")

; Get details of the mapping
MsgBox($MB_SYSTEMMODAL, "", "Drive X: is mapped to: " & DriveMapGet("X:"))
