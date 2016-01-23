#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 350, 200)

	Local $idButton = GUICtrlCreateButton("This is a button", 30, 32, 130, 28)
	Local $hButton = GUICtrlGetHandle($idButton)

	; Create a tooltip control
	Local $hToolTip = _GUIToolTip_Create($hGUI)
	; Set the maximum width to 400 pixels
	_GUIToolTip_SetMaxTipWidth($hToolTip, 400)

	_GUIToolTip_AddTool($hToolTip, 0, 'If the text exceeds the width, then it carries over to the next line.' & @CRLF & 'Also allows you to use @CRLF', $hButton)
	GUISetState(@SW_SHOW)
	; Display the max width of the tooltip
	MsgBox($MB_SYSTEMMODAL, "Info", "Max Width: " & _GUIToolTip_GetMaxTipWidth($hToolTip) & " Pixels")
	While 1
		If GUIGetMsg() = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd
	; Destroy the tooltip control
	_GUIToolTip_Destroy($hToolTip)
	GUIDelete($hGUI)
EndFunc   ;==>Example
