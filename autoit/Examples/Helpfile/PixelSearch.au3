#include <MsgBoxConstants.au3>

; Find a pure red pixel in the range 0,0-20,300
Local $aCoord = PixelSearch(0, 0, 20, 300, 0xFF0000)
If Not @error Then
	MsgBox($MB_SYSTEMMODAL, "", "X and Y are: " & $aCoord[0] & "," & $aCoord[1])
EndIf

; Find a pure red pixel or a red pixel within 10 shades variations of pure red
$aCoord = PixelSearch(0, 0, 20, 300, 0xFF0000, 10)
If Not @error Then
	MsgBox($MB_SYSTEMMODAL, "", "X and Y are: " & $aCoord[0] & "," & $aCoord[1])
EndIf
