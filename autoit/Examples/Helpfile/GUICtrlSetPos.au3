#include <GUIConstantsEx.au3>

Example()

Func Example()

	GUICreate("My GUI position") ; will create a dialog box that when displayed is centered

	GUISetFont(16)
	Local $idLabel = GUICtrlCreateLabel("my moving label", 10, 20)

	GUISetState(@SW_SHOW)

	Local $idMsg, $bToggle = False
	While 1
		$idMsg = GUIGetMsg()

		If $idMsg = $GUI_EVENT_CLOSE Then Exit
		$bToggle = Not $bToggle
		If $bToggle Then
			GUICtrlSetPos($idLabel, 20, 20)
		Else
			GUICtrlSetPos($idLabel, 20, 30)
		EndIf
		Sleep(160)
	WEnd
EndFunc   ;==>Example
