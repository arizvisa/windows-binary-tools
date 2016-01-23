#include <GUIConstantsEx.au3>
#include <GuiIPAddress.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGui, $hIPAddress

	$hGui = GUICreate("IP Address Control Clear Example", 400, 300)
	$hIPAddress = _GUICtrlIpAddress_Create($hGui, 10, 10)
	GUISetState(@SW_SHOW)

	_GUICtrlIpAddress_Set($hIPAddress, "24.168.2.128")

	; Clear the IP Address
	MsgBox($MB_SYSTEMMODAL, "Information", "Clear IP Address")
	_GUICtrlIpAddress_ClearAddress($hIPAddress)

	; Wait for user to close GUI
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example
