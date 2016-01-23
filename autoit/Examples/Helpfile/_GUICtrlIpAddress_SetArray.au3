#include <GUIConstantsEx.au3>
#include <GuiIPAddress.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hGui, $aIP[4] = [24, 168, 2, 128], $hIPAddress

	$hGui = GUICreate("IP Address Control Set (Array) Example", 400, 300)
	$hIPAddress = _GUICtrlIpAddress_Create($hGui, 2, 4, 125, 20)
	$g_idMemo = GUICtrlCreateEdit("", 2, 28, 396, 270, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	_GUICtrlIpAddress_SetArray($hIPAddress, $aIP)

	$aIP = _GUICtrlIpAddress_GetArray($hIPAddress)

	MemoWrite("Field 1 .....: " & $aIP[0])
	MemoWrite("Field 2 .....: " & $aIP[1])
	MemoWrite("Field 3 .....: " & $aIP[2])
	MemoWrite("Field 4 .....: " & $aIP[3])

	; Wait for user to close GUI
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
