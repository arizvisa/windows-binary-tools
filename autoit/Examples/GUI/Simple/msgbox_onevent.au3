; A simple custom messagebox that uses the OnEvent mode

#include <Constants.au3>
#include <GUIConstantsEx.au3>

Opt("GUIOnEventMode", 1)

Global $g_idExit

_Main()

Func _Main()
	Local $idYes, $idNo

	GUICreate("Custom MsgBox", 210, 80)

	GUICtrlCreateLabel("Please click a button!", 10, 10)
	$idYes = GUICtrlCreateButton("Yes", 10, 50, 50, 20)
	GUICtrlSetOnEvent($idYes, "OnYes")
	$idNo = GUICtrlCreateButton("No", 80, 50, 50, 20)
	GUICtrlSetOnEvent($idNo, "OnNo")
	$g_idExit = GUICtrlCreateButton("Exit", 150, 50, 50, 20)
	GUICtrlSetOnEvent($g_idExit, "OnExit")

	GUISetOnEvent($GUI_EVENT_CLOSE, "OnExit")

	GUISetState() ; display the GUI

	While 1
		Sleep(1000)
	WEnd
EndFunc   ;==>_Main

; --------------- Functions ---------------
Func OnYes()
	MsgBox($MB_SYSTEMMODAL, "You clicked on", "Yes")
EndFunc   ;==>OnYes

Func OnNo()
	MsgBox($MB_SYSTEMMODAL, "You clicked on", "No")
EndFunc   ;==>OnNo

Func OnExit()
	If @GUI_CtrlId = $g_idExit Then
		MsgBox($MB_SYSTEMMODAL, "You clicked on", "Exit")
	Else
		MsgBox($MB_SYSTEMMODAL, "You clicked on", "Close")
	EndIf

	Exit
EndFunc   ;==>OnExit
