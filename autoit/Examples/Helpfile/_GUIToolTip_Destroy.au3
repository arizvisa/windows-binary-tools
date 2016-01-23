#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
; Click the button to destroy the tooltip control
Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 350, 200)

	Local $idButton = GUICtrlCreateButton("This is a button", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($idButton)
	; create a tooltip control using default settings
	Local $hToolTip = _GUIToolTip_Create(0)

	; add a tool to the tooltip control
	_GUIToolTip_AddTool($hToolTip, 0, "This is a ToolTip", $hButton)
	_GUIToolTip_AddTool($hToolTip, 0, "ToolTip text for the GUI", $hGUI)
	GUISetState(@SW_SHOW)

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $idButton
				; Destroys the tooltip control
				_GUIToolTip_Destroy($hToolTip)
		EndSwitch
	WEnd
	; Destroy the tooltip control (in case the button hasn't been actioned yet)
	_GUIToolTip_Destroy($hToolTip)
	GUIDelete($hGUI)
EndFunc   ;==>Example
