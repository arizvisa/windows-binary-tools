#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 350, 200)

	Local $idButton = GUICtrlCreateButton("Button ToolTip", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($idButton)
	; Create a tooltip control
	Local $hToolTip = _GUIToolTip_Create($hGUI)

	; Add a tool to the tooltip control
	_GUIToolTip_AddTool($hToolTip, 0, "This is the ToolTip text", $hButton)

	; set the time for how long the tooltip displays, to 1500 ms
	_GUIToolTip_SetDelayTime($hToolTip, $TTDT_AUTOPOP, 1500)
	GUISetState(@SW_SHOW)
	; Retrieve and display the time that the tooltip displays
	MsgBox($MB_SYSTEMMODAL, 'Message', 'Display time : ' & _GUIToolTip_GetDelayTime($hToolTip, $TTDT_AUTOPOP) & ' ms')

	While 1
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
	GUIDelete($hGUI)
EndFunc   ;==>Example
