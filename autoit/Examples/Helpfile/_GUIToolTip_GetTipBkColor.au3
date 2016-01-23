#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <MsgBoxConstants.au3>
#include <WinAPITheme.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 350, 200)

	Local $idButton = GUICtrlCreateButton("Button", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($idButton)

	; Create a tooltip control
	Local $hToolTip = _GUIToolTip_Create($hGUI, $TTS_BALLOON)
	_WinAPI_SetWindowTheme($hToolTip, "", "")
	; Change the color settings for the tooltip, color setting is a COLORREF (BGR) value.
	_GUIToolTip_SetTipBkColor($hToolTip, 0x395A00)
	_GUIToolTip_SetTipTextColor($hToolTip, 0x1EBFFF)

	; Add a tool to the tooltip control
	_GUIToolTip_AddTool($hToolTip, 0, "This is the ToolTip text", $hButton)
	GUISetState(@SW_SHOW)

	; Retrieve the background color of the tooltip.
	MsgBox($MB_SYSTEMMODAL, 'Message', 'Background color : 0x' & Hex(_GUIToolTip_GetTipBkColor($hToolTip), 6))

	While 1
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
	GUIDelete($hGUI)
EndFunc   ;==>Example
