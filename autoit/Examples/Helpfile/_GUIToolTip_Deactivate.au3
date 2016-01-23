#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>

Example()

Func Example()
	Local $bActivate = True

	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 350, 200)

	Local $idToggleTips = GUICtrlCreateButton("Tips: On", 30, 32, 180, 28)
	Local $hToggleTips = GUICtrlGetHandle($idToggleTips)
	; create a tooltip control using the balloon style
	Local $hToolTip = _GUIToolTip_Create(0, $TTS_BALLOON)

	; add a tool to the tooltip control using the default settings.
	_GUIToolTip_AddTool($hToolTip, 0, "Tooltip for the GUI", $hGUI)
	; add a tool to the tooltip control centering the tip below the button instead of above the mouse pointer
	_GUIToolTip_AddTool($hToolTip, 0, "This button toggles the tooltips on and off", $hToggleTips, 0, 0, 0, 0, BitOR($TTF_CENTERTIP, $TTF_SUBCLASS, $TTF_IDISHWND))
	GUISetState(@SW_SHOW)

	While 1
		Switch GUIGetMsg()
			Case $idToggleTips
				$bActivate = Not $bActivate
				If $bActivate Then
					_GUIToolTip_Activate($hToolTip)
					GUICtrlSetData($idToggleTips, 'Tips: On')
				Else
					_GUIToolTip_Deactivate($hToolTip)
					GUICtrlSetData($idToggleTips, 'Tips: Off')
				EndIf
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
	GUIDelete($hGUI)
EndFunc   ;==>Example
