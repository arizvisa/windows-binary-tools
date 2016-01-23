#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <MsgBoxConstants.au3>

Global $g_hToolTip

; Press the "g" key to display the information
HotKeySet("g", "Get_Tool")

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 350, 200)

	Local $idButton = GUICtrlCreateButton("Button ToolTip", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($idButton)
	; create a tooltip control using default settings
	$g_hToolTip = _GUIToolTip_Create(0)

	; add a tool to the tooltip control
	_GUIToolTip_AddTool($g_hToolTip, 0, "This is a ToolTip", $hButton)
	GUISetState(@SW_SHOW)
	While 1
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($g_hToolTip)
	GUIDelete($hGUI)
EndFunc   ;==>Example

Func Get_Tool()
	; This will display "True" if the tool is displaying
	MsgBox($MB_SYSTEMMODAL, "", "Tooltip Exists = " & _GUIToolTip_ToolExists($g_hToolTip))
EndFunc   ;==>Get_Tool
