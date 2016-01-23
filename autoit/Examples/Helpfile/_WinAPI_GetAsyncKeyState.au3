#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WinAPI.au3>
#include <WinAPIvkeysConstants.au3>

Example()

Func Example()
	Local $hGUI = GUICreate("_WinAPI_GetAsyncKeyState Demo", 500, 300)
	GUICtrlCreateLabel("Press the number to select the task you wish to use from list below", 10, 30)
	GUICtrlCreateLabel("Press 1 key for task 1" & @CRLF & @CRLF & _
			"Press 2 key for task 2" & @CRLF & @CRLF & _
			"Press 3 key for task 3" & @CRLF & @CRLF & _
			"Press the ESCAPE key, or click the close button, to exit", 10, 60)
	GUISetState(@SW_SHOW)

	Local Const $iBitMask = 0x8000 ; a bit mask to strip the high word bits from the return of the function.
	While GUIGetMsg() <> $GUI_EVENT_CLOSE
		If BitAND(_WinAPI_GetAsyncKeyState($VK_1), $iBitMask) <> 0 Or BitAND(_WinAPI_GetAsyncKeyState($VK_NUMPAD1), $iBitMask) <> 0 Then
			MsgBox($MB_SYSTEMMODAL, "_WinAPI_GetAsyncKeyState", "Task 1")
		ElseIf BitAND(_WinAPI_GetAsyncKeyState($VK_2), $iBitMask) <> 0 Or BitAND(_WinAPI_GetAsyncKeyState($VK_NUMPAD2), $iBitMask) <> 0 Then
			MsgBox($MB_SYSTEMMODAL, "_WinAPI_GetAsyncKeyState", "Task 2")
		ElseIf BitAND(_WinAPI_GetAsyncKeyState($VK_3), $iBitMask) <> 0 Or BitAND(_WinAPI_GetAsyncKeyState($VK_NUMPAD3), $iBitMask) <> 0 Then
			MsgBox($MB_SYSTEMMODAL, "_WinAPI_GetAsyncKeyState", "Task 3")
		ElseIf BitAND(_WinAPI_GetAsyncKeyState($VK_ESCAPE), $iBitMask) <> 0 Then
			MsgBox($MB_SYSTEMMODAL, "_WinAPI_GetAsyncKeyState", "The Esc Key was pressed, exiting.")
			ExitLoop
		EndIf
	WEnd
	GUIDelete($hGUI)
EndFunc   ;==>Example
