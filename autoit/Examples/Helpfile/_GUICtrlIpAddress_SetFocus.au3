#include <GUIConstantsEx.au3>
#include <GuiIPAddress.au3>

Example()

Func Example()
	Local $hGui, $hIPAddress

	$hGui = GUICreate("IP Address Control Set Focus Example", 400, 300)
	$hIPAddress = _GUICtrlIpAddress_Create($hGui, 2, 4)
	GUISetState(@SW_SHOW)

	_GUICtrlIpAddress_Set($hIPAddress, "24.168.2.128")

	_GUICtrlIpAddress_SetFocus($hIPAddress, 1)
	; Wait for user to close GUI
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example
