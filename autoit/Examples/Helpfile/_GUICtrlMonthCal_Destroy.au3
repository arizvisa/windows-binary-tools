#include <GUIConstantsEx.au3>
#include <GuiMonthCal.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $hGUI, $hHandleBefore, $hMonthCal

	; Create GUI
	$hGUI = GUICreate("Month Calendar Destroy", 400, 300)
	$hMonthCal = _GUICtrlMonthCal_Create($hGUI, 4, 4, $WS_BORDER)
	GUISetState(@SW_SHOW)

	$hHandleBefore = $hMonthCal
	MsgBox($MB_SYSTEMMODAL, "Information", "Destroying the Control for Handle: " & $hMonthCal)
	MsgBox($MB_SYSTEMMODAL, "Information", "Control Destroyed: " & _GUICtrlMonthCal_Destroy($hMonthCal) & @CRLF & _
			"Handel Before Destroy: " & $hHandleBefore & @CRLF & _
			"Handle After Destroy: " & $hMonthCal)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
