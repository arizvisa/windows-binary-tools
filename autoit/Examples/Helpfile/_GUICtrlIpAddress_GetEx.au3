#include <GUIConstantsEx.au3>
#include <GuiIPAddress.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hGui, $tIP = DllStructCreate($tagGetIPAddress), $aIP[4] = [24, 168, 2, 128], $hIPAddress

	$hGui = GUICreate("IP Address Control GetEx Example", 400, 300)
	$hIPAddress = _GUICtrlIpAddress_Create($hGui, 2, 4, 125, 20)
	$g_idMemo = GUICtrlCreateEdit("", 2, 28, 396, 270, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	For $x = 0 To 3
		DllStructSetData($tIP, "Field" & $x + 1, $aIP[$x])
	Next

	_GUICtrlIpAddress_SetEx($hIPAddress, $tIP)

	$tIP = _GUICtrlIpAddress_GetEx($hIPAddress)

	For $x = 0 To 3
		MemoWrite("Field " & $x + 1 & " .....: " & DllStructGetData($tIP, "Field" & $x + 1))
	Next

	; Wait for user to close GUI
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
