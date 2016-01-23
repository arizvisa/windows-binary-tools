#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <MsgBoxConstants.au3>
#include <WinAPITheme.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 350, 200)

	Local $idAdd = GUICtrlCreateButton("Button ToolTip", 30, 32, 130, 28)
	Local $hAdd = GUICtrlGetHandle($idAdd)
	; Create a tooltip control
	Local $hToolTip1 = _GUIToolTip_Create(0)
	; If using a Windows theme setting, this will disable that for the tooltip displayed, so you can change
	; the margins and have the change seen
	_WinAPI_SetWindowTheme($hToolTip1, "", "")

	Local $hToolTip2 = _GUIToolTip_Create(0)
	_WinAPI_SetWindowTheme($hToolTip2, "", "")
	; This is only used because the tooltip is a multiline tool, you don't need this to change
	; the margins
	_GUIToolTip_SetMaxTipWidth($hToolTip1, 400)
	_GUIToolTip_SetMaxTipWidth($hToolTip2, 400)

	; Manually set the margins of the tooltip instead of using default settings.
	_GUIToolTip_SetMargin($hToolTip1, 30, 10, 20, 12)

	Local $aMargins = _GUIToolTip_GetMargin($hToolTip1)
	Local $aMargins1 = _GUIToolTip_GetMargin($hToolTip2)

	; Add a tool to the first tooltip control
	_GUIToolTip_AddTool($hToolTip1, 0, 'Left : ' & $aMargins[0] & @LF & _
			'Top : ' & $aMargins[1] & @LF & _
			'Right : ' & $aMargins[2] & @LF & _
			'Bottom : ' & $aMargins[3], $hAdd)
	_GUIToolTip_SetTitle($hToolTip1, "This is the ToolTip with manually set margins")
	; Add a tool to the second tooltip control
	_GUIToolTip_AddTool($hToolTip2, 0, 'Left : ' & $aMargins1[0] & @LF & _
			'Top : ' & $aMargins1[1] & @LF & _
			'Right : ' & $aMargins1[2] & @LF & _
			'Bottom : ' & $aMargins1[3], $hGUI)
	_GUIToolTip_SetTitle($hToolTip2, "This is the ToolTip with default margins")
	GUISetState(@SW_SHOW)
	While 1
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip1)
	GUIDelete($hGUI)
EndFunc   ;==>Example
