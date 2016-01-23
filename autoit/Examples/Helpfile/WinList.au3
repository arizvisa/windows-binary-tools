#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Retrieve a list of window handles.
	Local $aList = WinList()

	; Loop through the array displaying only visable windows with a title.
	For $i = 1 To $aList[0][0]
		If $aList[$i][0] <> "" And BitAND(WinGetState($aList[$i][1]), 2) Then
			MsgBox($MB_SYSTEMMODAL, "", "Title: " & $aList[$i][0] & @CRLF & "Handle: " & $aList[$i][1])
		EndIf
	Next
EndFunc   ;==>Example
