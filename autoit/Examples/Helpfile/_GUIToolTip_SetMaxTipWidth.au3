#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 350, 200)

	Local $idButton = GUICtrlCreateButton("Button ToolTip", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($idButton)

	; Create a ToolTip control
	Local $hToolTip = _GUIToolTip_Create($hGUI)
	; Set the maximum width to 400 pixels
	_GUIToolTip_SetMaxTipWidth($hToolTip, 400)
	; Add a multi-line tool to the ToolTip control using @CRLF to break the text into 2 lines
	_GUIToolTip_AddTool($hToolTip, 0, 'If the text exceeds the width, then it carries over to the next line.' & @CRLF & 'Also allows you to use @CRLF', $hButton)
	; Add a multi-line tool to the ToolTip control using the MaxTipWidth setting to break the text into 2 lines.
	_GUIToolTip_AddTool($hToolTip, 0, 'If the text exceeds the width, then it carries over to the next line. Also allows you to use @CRLF', $hGUI)
	GUISetState(@SW_SHOW)

	While 1
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	; Destroy the ToolTip control
	_GUIToolTip_Destroy($hToolTip)
	GUIDelete($hGUI)
EndFunc   ;==>Example
