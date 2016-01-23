; A simple custom messagebox that uses the MessageLoop mode

#include <Constants.au3>
#include <GUIConstantsEx.au3>

_Main()

Func _Main()
	Local $idYes, $idNo, $idExit, $iMsg

	GUICreate("Custom MsgBox", 210, 80)

	GUICtrlCreateLabel("Please click a button!", 10, 10)
	$idYes = GUICtrlCreateButton("Yes", 10, 50, 50, 20)
	$idNo = GUICtrlCreateButton("No", 80, 50, 50, 20)
	$idExit = GUICtrlCreateButton("Exit", 150, 50, 50, 20)

	GUISetState() ; display the GUI

	Do
		$iMsg = GUIGetMsg()

		Select
			Case $iMsg = $idYes
				MsgBox($MB_SYSTEMMODAL, "You clicked on", "Yes")
			Case $iMsg = $idNo
				MsgBox($MB_SYSTEMMODAL, "You clicked on", "No")
			Case $iMsg = $idExit
				MsgBox($MB_SYSTEMMODAL, "You clicked on", "Exit")
			Case $iMsg = $GUI_EVENT_CLOSE
				MsgBox($MB_SYSTEMMODAL, "You clicked on", "Close")
		EndSelect
	Until $iMsg = $GUI_EVENT_CLOSE Or $iMsg = $idExit
EndFunc   ;==>_Main
