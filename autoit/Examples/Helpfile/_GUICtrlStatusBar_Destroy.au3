#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI, $hHandleBefore, $hStatus
	Local $aParts[3] = [75, 150, -1]

	; Create GUI
	$hGUI = GUICreate("StatusBar Destroy", 400, 300)

	; defaults to 1 part, no text
	$hStatus = _GUICtrlStatusBar_Create($hGUI)
	_GUICtrlStatusBar_SetParts($hStatus, $aParts)

	GUISetState(@SW_SHOW)

	$hHandleBefore = $hStatus
	MsgBox($MB_SYSTEMMODAL, "Information", "Destroying the Control for Handle: " & $hStatus)
	MsgBox($MB_SYSTEMMODAL, "Information", "Control Destroyed: " & _GUICtrlStatusBar_Destroy($hStatus) & @CRLF & _
			"Handle Before Destroy: " & $hHandleBefore & @CRLF & _
			"Handle After Destroy: " & $hStatus)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
