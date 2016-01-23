#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $idButton
	GUICreate("test")
	$idButton = GUICtrlCreateButton("testing", 0, 0)
	MsgBox($MB_SYSTEMMODAL, "ID", "Dialog Control ID: " & _WinAPI_GetDlgCtrlID(GUICtrlGetHandle($idButton)))
EndFunc   ;==>Example
