#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>

Example()

Func Example()
	Local $iMsg
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 350, 200)

	Local $idButton = GUICtrlCreateButton("This is a button", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($idButton)
	; create a tooltip control using default settings
	Local $hToolTip = _GUIToolTip_Create(0)
	_GUIToolTip_SetMaxTipWidth($hToolTip, 400)
	; add a tool to the tooltip control
	_GUIToolTip_AddTool($hToolTip, 0, "Click this to delete the tooltip" & @CRLF & "for this button", $hButton)
	_GUIToolTip_AddTool($hToolTip, 0, "ToolTip text for the GUI", $hGUI)
	GUISetState(@SW_SHOW)

	While 1
		$iMsg = GUIGetMsg()
		Switch $iMsg
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $idButton
				; Deletes the tooltip assigned to the button, but not the tooltip control
				; or the tool for the GUI
				_GUIToolTip_DelTool($hToolTip, 0, $hButton)
		EndSwitch
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
	GUIDelete($hGUI)
EndFunc   ;==>Example
