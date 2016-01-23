#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <StaticConstants.au3>

; This example demonstrates how to add a tool, it does not assign the tool to any control, just an area of the GUI
Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 350, 200)
	; create frames to indicate where the tooltip will display when the mouse is in the
	; correct location on the GUI, these frames do not have a tooltip assigned to it
	; these frames are ONLY for visual representation as to where the tooltip will display,
	; they are not needed to make the tooltip display.
	GUICtrlCreateLabel("", 10, 10, 160, 75, $SS_ETCHEDFRAME)
	; this label control must be disabled or the tooltip will not display when the mouse
	; is over it.
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreateLabel("", 10, 84, 160, 75, $SS_ETCHEDFRAME)
	; this label control must be disabled or the tooltip will not display when the mouse
	; is over it.
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreateLabel("", 169, 10, 160, 75, $SS_ETCHEDFRAME)
	; this label control must be disabled or the tooltip will not display when the mouse
	; is over it.
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreateLabel("", 169, 84, 160, 75, $SS_ETCHEDFRAME)
	; this label control must be disabled or the tooltip will not display when the mouse
	; is over it.
	GUICtrlSetState(-1, $GUI_DISABLE)
	Local $idButton = GUICtrlCreateButton("This is a button", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($idButton)
	; create a tooltip control using default settings
	Local $hToolTip = _GUIToolTip_Create(0)

	; add 4 tools to the tooltip control, these tools are created using the location on the GUI
	; rather than assigning them to a specific control.
	_GUIToolTip_AddTool($hToolTip, $hGUI, "Upper Left corner", 0, 10, 10, 168, 85, $TTF_SUBCLASS)
	_GUIToolTip_AddTool($hToolTip, $hGUI, "Upper Right corner", 0, 168, 10, 328, 85, $TTF_SUBCLASS)
	_GUIToolTip_AddTool($hToolTip, $hGUI, "Lower Left corner", 0, 10, 85, 168, 160, $TTF_SUBCLASS)
	_GUIToolTip_AddTool($hToolTip, $hGUI, "Lower Right corner", 0, 168, 85, 328, 160, $TTF_SUBCLASS)
	; add a tool to the tooltip control that is assigned to the button control
	_GUIToolTip_AddTool($hToolTip, 0, "This tooltip belongs to the button", $hButton)
	GUISetState(@SW_SHOW)

	While 1
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
	GUIDelete($hGUI)
EndFunc   ;==>Example
