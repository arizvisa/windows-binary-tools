#include <GUIConstantsEx.au3>
#include <GuiIPAddress.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hGui, $hIPAddress

	$hGui = GUICreate("IP Address Control IsBlank Example", 400, 300)
	$hIPAddress = _GUICtrlIpAddress_Create($hGui, 2, 4)
	$g_idMemo = GUICtrlCreateEdit("", 2, 28, 396, 270, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; See if IP Address is blank
	MemoWrite("Blank: " & _GUICtrlIpAddress_IsBlank($hIPAddress))

	Sleep(1000)

	_GUICtrlIpAddress_Set($hIPAddress, "24.168.2.128")

	; See if IP Address is blank
	MemoWrite("Blank: " & _GUICtrlIpAddress_IsBlank($hIPAddress))

	; Wait for user to close GUI
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
