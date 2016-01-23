#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <WinAPITheme.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 350, 200)

	Local $idButton = GUICtrlCreateButton("Button ToolTip", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($idButton)

	; Create a tooltip control
	Local $hToolTip = _GUIToolTip_Create($hGUI, $TTS_BALLOON)
	; If using a Windows theme setting, this will disable that for the tooltip displayed, so you can color it
	; it has to be placed before you try to actually set the colors, doing it after will reset the colors.
	_WinAPI_SetWindowTheme($hToolTip, "", "")

	; The color value used in the _GUIToolTip_SetTipBkColor function is a COLORREF (BGR) value.
	_GUIToolTip_SetTipBkColor($hToolTip, 0x395A00)
	; The color value used in the _GUIToolTip_SetTipTextColor function is a COLORREF (BGR) value.
	_GUIToolTip_SetTipTextColor($hToolTip, 0x1EBFFF)

	; add a tool to the tooltip control
	_GUIToolTip_AddTool($hToolTip, 0, "This is the ToolTip text", $hButton)
	GUISetState(@SW_SHOW)

	While 1
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
	GUIDelete($hGUI)
EndFunc   ;==>Example
