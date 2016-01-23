#include <GUIConstantsEx.au3>
#include <GuiDateTimePicker.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI, $hHandleBefore, $hDTP

	; Create GUI
	$hGUI = GUICreate("(UDF Created) DateTimePick Destroy", 400, 300)
	$hDTP = _GUICtrlDTP_Create($hGUI, 2, 6, 190)
	GUISetState(@SW_SHOW)

	MsgBox($MB_SYSTEMMODAL, "Information", "Destroying the Control for Handle: " & $hDTP)
	$hHandleBefore = $hDTP
	MsgBox($MB_SYSTEMMODAL, "Information", "Control Destroyed: " & _GUICtrlDTP_Destroy($hDTP) & @CRLF & _
			"Handel Before Destroy: " & $hHandleBefore & @CRLF & _
			"Handle After Destroy: " & $hDTP)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
