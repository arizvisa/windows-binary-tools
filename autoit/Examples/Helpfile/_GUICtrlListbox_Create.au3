#include <GUIConstantsEx.au3>
#include <GuiListBox.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Global $g_hListBox

Example()

Func Example()
	Local $hGUI

	; Create GUI
	$hGUI = GUICreate("(UDF Created) List Box Create", 400, 296)
	$g_hListBox = _GUICtrlListBox_Create($hGUI, "String upon creation", 2, 2, 396, 296)
	GUISetState(@SW_SHOW)

	MsgBox($MB_SYSTEMMODAL, "Information", "Adding Items")

	GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")

	; Add files
	_GUICtrlListBox_BeginUpdate($g_hListBox)
	_GUICtrlListBox_ResetContent($g_hListBox)
	_GUICtrlListBox_InitStorage($g_hListBox, 100, 4096)
	_GUICtrlListBox_Dir($g_hListBox, @WindowsDir & "\win*.exe")
	_GUICtrlListBox_AddFile($g_hListBox, @WindowsDir & "\notepad.exe")
	_GUICtrlListBox_Dir($g_hListBox, "", $DDL_DRIVES)
	_GUICtrlListBox_Dir($g_hListBox, "", $DDL_DRIVES, False)
	_GUICtrlListBox_EndUpdate($g_hListBox)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg
	Local $hWndFrom, $iIDFrom, $iCode, $hWndListBox
	If Not IsHWnd($g_hListBox) Then $hWndListBox = GUICtrlGetHandle($g_hListBox)
	$hWndFrom = $lParam
	$iIDFrom = BitAND($wParam, 0xFFFF) ; Low Word
	$iCode = BitShift($wParam, 16) ; Hi Word

	Switch $hWndFrom
		Case $g_hListBox, $hWndListBox
			Switch $iCode
				Case $LBN_DBLCLK ; Sent when the user double-clicks a string in a list box
					_DebugPrint("$LBN_DBLCLK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; no return value
				Case $LBN_ERRSPACE ; Sent when a list box cannot allocate enough memory to meet a specific request
					_DebugPrint("$LBN_ERRSPACE" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; no return value
				Case $LBN_KILLFOCUS ; Sent when a list box loses the keyboard focus
					_DebugPrint("$LBN_KILLFOCUS" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; no return value
				Case $LBN_SELCANCEL ; Sent when the user cancels the selection in a list box
					_DebugPrint("$LBN_SELCANCEL" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; no return value
				Case $LBN_SELCHANGE ; Sent when the selection in a list box has changed
					_DebugPrint("$LBN_SELCHANGE" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; no return value
				Case $LBN_SETFOCUS ; Sent when a list box receives the keyboard focus
					_DebugPrint("$LBN_SETFOCUS" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; no return value
			EndSwitch
	EndSwitch
	; Proceed the default AutoIt3 internal message commands.
	; You also can complete let the line out.
	; !!! But only 'Return' (without any value) will not proceed
	; the default AutoIt3-message in the future !!!
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND

Func _DebugPrint($s_Text)
	$s_Text = StringReplace($s_Text, @CRLF, @CRLF & "-->")
	ConsoleWrite("!===========================================================" & @CRLF & _
			"+===========================================================" & @CRLF & _
			"-->" & $s_Text & @CRLF & _
			"+===========================================================" & @CRLF)
EndFunc   ;==>_DebugPrint
