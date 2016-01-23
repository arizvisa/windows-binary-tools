#include <Misc.au3>
#include <MsgBoxConstants.au3>

Local $a_vFont = _ChooseFont("Arial", 8)
If (@error) Then
	MsgBox($MB_SYSTEMMODAL, "", "Error _ChooseFont: " & @error)
Else
	MsgBox($MB_SYSTEMMODAL, "", "Font Name: " & $a_vFont[2] & @CRLF & "Size: " & $a_vFont[3] & @CRLF & "Weight: " & $a_vFont[4] & @CRLF & "COLORREF rgbColors: " & $a_vFont[5] & @CRLF & "Hex BGR Color: " & $a_vFont[6] & @CRLF & "Hex RGB Color: " & $a_vFont[7])
EndIf
