#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <MsgBoxConstants.au3>

Global $g_hToolTip

; Hover over the button on the GUI and press the "g" key to disply the information
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
	Local $aTool = _GUIToolTip_GetCurrentTool($g_hToolTip)
	MsgBox($MB_SYSTEMMODAL, "Tooltip info", "Flags: " & @TAB & _GUIToolTip_BitsToTTF($aTool[0]) & @CRLF & _
			"HWnd: " & @TAB & $aTool[1] & @CRLF & _
			"ID: " & @TAB & $aTool[2] & @CRLF & _
			"Left X:" & @TAB & $aTool[3] & @CRLF & _
			"Left Y:" & @TAB & $aTool[4] & @CRLF & _
			"Right X:" & @TAB & $aTool[5] & @CRLF & _
			"Right Y:" & @TAB & $aTool[6] & @CRLF & _
			"Instance:" & @TAB & $aTool[7] & @CRLF & _
			"Text:" & @TAB & $aTool[8] & @CRLF & _
			"lParam:" & @TAB & $aTool[9])
EndFunc   ;==>Get_Tool
