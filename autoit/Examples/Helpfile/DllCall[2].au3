#include <MsgBoxConstants.au3>

; Calling a function that modifies parameters,
Local $iPID = Run("notepad")

Local $hWnd = WinWait("[CLASS:Notepad]", "", 2000)

If $hWnd = 0 Then
	; Timeout occured.
	Exit MsgBox($MB_SYSTEMMODAL, Default, "Unable to start notepad!")
EndIf

Local $aResult = DllCall("user32.dll", "int", "GetWindowText", "hwnd", $hWnd, "str", "", "int", 32768)
MsgBox($MB_SYSTEMMODAL, Default, "Number of characters returned: " & $aResult[0])
MsgBox($MB_SYSTEMMODAL, Default, "Text (returned in parameter 2): '" & $aResult[2] & "'")

WinClose($hWnd)
