#include <Color.au3>
#include <MsgBoxConstants.au3>

Local $nColor = 0x8090ff

Local $aColor = _ColorGetRGB($nColor)
MsgBox($MB_SYSTEMMODAL, "AutoIt", "Color=" & Hex($nColor) & @CRLF & " Red=" & Hex($aColor[0], 2) & " Blue=" & Hex($aColor[1], 2) & " Green=" & Hex($aColor[2], 2))
