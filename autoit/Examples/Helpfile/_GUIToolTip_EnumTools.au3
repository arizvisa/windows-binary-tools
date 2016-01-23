#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 350, 200)

	Local $idButton = GUICtrlCreateButton("This is a button", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($idButton)
	; create a tooltip control using default settings
	Local $hToolTip = _GUIToolTip_Create(0)

	; add a tool to the tooltip control
	_GUIToolTip_AddTool($hToolTip, 0, "This is a ToolTip", $hButton)
	_GUIToolTip_AddTool($hToolTip, 0, "This is the GUI ToolTip", $hGUI)
	GUISetState(@SW_SHOW)
	; GetToolCount returns 2, but tools are numbered starting from zero (0), so we have to subtract 1
	For $I = 0 To _GUIToolTip_GetToolCount($hToolTip) - 1
		Local $aTool = _GUIToolTip_EnumTools($hToolTip, $I)
		MsgBox($MB_SYSTEMMODAL, "Tooltip info for tooltip - " & $I, "Flags: " & @TAB & _GUIToolTip_BitsToTTF($aTool[0]) & @CRLF & _
				"HWnd: " & @TAB & $aTool[1] & @CRLF & _
				"ID: " & @TAB & $aTool[2] & @CRLF & _
				"Left X:" & @TAB & $aTool[3] & @CRLF & _
				"Left Y:" & @TAB & $aTool[4] & @CRLF & _
				"Right X:" & @TAB & $aTool[5] & @CRLF & _
				"Right Y:" & @TAB & $aTool[6] & @CRLF & _
				"Instance:" & @TAB & $aTool[7] & @CRLF & _
				"Text:" & @TAB & $aTool[8] & @CRLF & _
				"lParam:" & @TAB & $aTool[9])
	Next

	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
	GUIDelete($hGUI)
EndFunc   ;==>Example
