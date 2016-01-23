#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 350, 200)

	Local $idButton = GUICtrlCreateButton("Button", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($idButton)

	; Create a tooltip control
	Local $hToolTip = _GUIToolTip_Create($hGUI)

	; Add a tool to the tooltip control
	_GUIToolTip_AddTool($hToolTip, 0, "Click this to change tooltip text", $hButton)
	GUISetState(@SW_SHOW)
	Local $bNew = False
	While 1
		Switch GUIGetMsg()
			Case $idButton ; Press the button to change the text of the tooltip
				$bNew = Not $bNew
				If $bNew Then
					_GUIToolTip_UpdateTipText($hToolTip, 0, $hButton, 'New text')
				Else
					_GUIToolTip_UpdateTipText($hToolTip, 0, $hButton, "Click this to change tooltip text")
				EndIf
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
	GUIDelete($hGUI)
EndFunc   ;==>Example
