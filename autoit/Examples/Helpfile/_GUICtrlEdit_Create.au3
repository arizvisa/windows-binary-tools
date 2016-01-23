#include <GUIConstantsEx.au3>
#include <WinAPI.au3> ; used for Lo/Hi word
#include <GuiEdit.au3>
#include <WindowsConstants.au3>

Global $g_hEdit

Example()

Func Example()
	Local $hGUI

	; Create GUI
	$hGUI = GUICreate("Edit Create", 400, 300)
	$g_hEdit = _GUICtrlEdit_Create($hGUI, "This is a test" & @CRLF & "Another Line", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")

	_GUICtrlEdit_AppendText($g_hEdit, @CRLF & "Append to the end?")

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg
	Local $hWndFrom, $iIDFrom, $iCode, $hWndEdit
	If Not IsHWnd($g_hEdit) Then $hWndEdit = GUICtrlGetHandle($g_hEdit)
	$hWndFrom = $lParam
	$iIDFrom = _WinAPI_LoWord($wParam)
	$iCode = _WinAPI_HiWord($wParam)
	Switch $hWndFrom
		Case $g_hEdit, $hWndEdit
			Switch $iCode
				Case $EN_ALIGN_LTR_EC ; Sent when the user has changed the edit control direction to left-to-right
					_DebugPrint("$EN_ALIGN_LTR_EC" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; no return value
				Case $EN_ALIGN_RTL_EC ; Sent when the user has changed the edit control direction to right-to-left
					_DebugPrint("$EN_ALIGN_RTL_EC" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; no return value
				Case $EN_CHANGE ; Sent when the user has taken an action that may have altered text in an edit control
					_DebugPrint("$EN_CHANGE" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; no return value
				Case $EN_ERRSPACE ; Sent when an edit control cannot allocate enough memory to meet a specific request
					_DebugPrint("$EN_ERRSPACE" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; no return value
				Case $EN_HSCROLL ; Sent when the user clicks an edit control's horizontal scroll bar
					_DebugPrint("$EN_HSCROLL" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; no return value
				Case $EN_KILLFOCUS ; Sent when an edit control loses the keyboard focus
					_DebugPrint("$EN_KILLFOCUS" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; no return value
				Case $EN_MAXTEXT ; Sent when the current text insertion has exceeded the specified number of characters for the edit control
					_DebugPrint("$EN_MAXTEXT" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; This message is also sent when an edit control does not have the $ES_AUTOHSCROLL style and the number of characters to be
					; inserted would exceed the width of the edit control.
					; This message is also sent when an edit control does not have the $ES_AUTOVSCROLL style and the total number of lines resulting
					; from a text insertion would exceed the height of the edit control

					; no return value
				Case $EN_SETFOCUS ; Sent when an edit control receives the keyboard focus
					_DebugPrint("$EN_SETFOCUS" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; no return value
				Case $EN_UPDATE ; Sent when an edit control is about to redraw itself
					_DebugPrint("$EN_UPDATE" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; no return value
				Case $EN_VSCROLL ; Sent when the user clicks an edit control's vertical scroll bar or when the user scrolls the mouse wheel over the edit control
					_DebugPrint("$EN_VSCROLL" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; no return value
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND

Func _DebugPrint($s_Text, $sLine = @ScriptLineNumber)
	ConsoleWrite( _
			"!===========================================================" & @CRLF & _
			"+======================================================" & @CRLF & _
			"-->Line(" & StringFormat("%04d", $sLine) & "):" & @TAB & $s_Text & @CRLF & _
			"+======================================================" & @CRLF)
EndFunc   ;==>_DebugPrint
