#include <Color.au3>
#include <MsgBoxConstants.au3>

Local $iColor = 0x8090FF

Local $aColor = _ColorGetCOLORREF($iColor)
MsgBox($MB_SYSTEMMODAL, "", "Color=" & Hex($iColor) & @CRLF & @CRLF & "Red=" & Hex($aColor[0], 2) & " Green=" & Hex($aColor[1], 2) & " Blue=" & Hex($aColor[2], 2))
