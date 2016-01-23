#include <GUIConstantsEx.au3>
#include <FontConstants.au3>

Example()

Func Example()
	GUICreate("My GUI default font") ; will create a dialog box that when displayed is centered

	Local $sFont = "Comic Sans MS"
	GUISetFont(9,  $FW_NORMAL, $GUI_FONTUNDER, $sFont) ; will display underlined characters
	GUICtrlCreateLabel("underlined label", 10, 20)

	GUISetFont(9,  $FW_NORMAL, $GUI_FONTITALIC, $sFont) ; will display underlined characters
	GUICtrlCreateLabel("italic label", 10, 40)

	GUISetFont(9,  $FW_NORMAL, $GUI_FONTSTRIKE, $sFont) ; will display underlined characters
	GUICtrlCreateLabel("strike label", 10, 60)

	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd

	GUIDelete()
EndFunc   ;==>Example
