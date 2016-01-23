#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <WindowsConstants.au3>

Global $g_idMemo, $g_hMainGUI, $g_hStatus

Example()

Func Example()
	Local $hGUI
	Local $aText[3] = ["Left Justified", @TAB & "Centered", @TAB & @TAB & "Right Justified"]

	; Create GUI
	$hGUI = GUICreate("(Example 4) StatusBar Create", 400, 300)

	; will create part widths based on part size passed in
	$g_hStatus = _GUICtrlStatusBar_Create($hGUI, 100, $aText)
	; Create memo control
	$g_idMemo = GUICtrlCreateEdit("", 2, 2, 396, 274, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUICtrlSendMsg($g_idMemo, $EM_SETREADONLY, True, 0)
	GUICtrlSetBkColor($g_idMemo, 0xFFFFFF)
	GUISetState(@SW_SHOW)

	MemoWrite("StatusBar Created with:" & @CRLF & _
			@TAB & "only Handle," & @CRLF & _
			@TAB & "part width number" & @CRLF & _
			@TAB & "part text array of 3 elements" & @CRLF)

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	; Get border sizes
	MemoWrite("Horizontal border width .: " & _GUICtrlStatusBar_GetBordersHorz($g_hStatus))
	MemoWrite("Vertical border width ...: " & _GUICtrlStatusBar_GetBordersVert($g_hStatus))
	MemoWrite("Width between rectangles : " & _GUICtrlStatusBar_GetBordersRect($g_hStatus))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUISetState(@SW_ENABLE, $g_hMainGUI)
	GUIDelete($hGUI)
EndFunc   ;==>Example

; Write message to memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite

Func WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR

	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Local $tInfo
	Switch $hWndFrom
		Case $g_hStatus
			Switch $iCode
				Case $NM_CLICK ; The user has clicked the left mouse button within the control
					$tInfo = DllStructCreate($tagNMMOUSE, $lParam)
					$hWndFrom = HWnd(DllStructGetData($tInfo, "hWndFrom"))
					$iIDFrom = DllStructGetData($tInfo, "IDFrom")
					$iCode = DllStructGetData($tInfo, "Code")
					_DebugPrint("$NM_CLICK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->ItemSpec:" & @TAB & DllStructGetData($tInfo, "ItemSpec") & @CRLF & _
							"-->ItemData:" & @TAB & DllStructGetData($tInfo, "ItemData") & @CRLF & _
							"-->X:" & @TAB & DllStructGetData($tInfo, "X") & @CRLF & _
							"-->Y:" & @TAB & DllStructGetData($tInfo, "Y") & @CRLF & _
							"-->HitInfo:" & @TAB & DllStructGetData($tInfo, "HitInfo"))
					Return True ; indicate that the mouse click was handled and suppress default processing by the system
					; Return FALSE ;to allow default processing of the click.
				Case $NM_DBLCLK ; The user has double-clicked the left mouse button within the control
					$tInfo = DllStructCreate($tagNMMOUSE, $lParam)
					$hWndFrom = HWnd(DllStructGetData($tInfo, "hWndFrom"))
					$iIDFrom = DllStructGetData($tInfo, "IDFrom")
					$iCode = DllStructGetData($tInfo, "Code")
					_DebugPrint("$NM_DBLCLK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->ItemSpec:" & @TAB & DllStructGetData($tInfo, "ItemSpec") & @CRLF & _
							"-->ItemData:" & @TAB & DllStructGetData($tInfo, "ItemData") & @CRLF & _
							"-->X:" & @TAB & DllStructGetData($tInfo, "X") & @CRLF & _
							"-->Y:" & @TAB & DllStructGetData($tInfo, "Y") & @CRLF & _
							"-->HitInfo:" & @TAB & DllStructGetData($tInfo, "HitInfo"))
					Return True ; indicate that the mouse click was handled and suppress default processing by the system
					; Return FALSE ;to allow default processing of the click.
				Case $NM_RCLICK ; The user has clicked the right mouse button within the control
					$tInfo = DllStructCreate($tagNMMOUSE, $lParam)
					$hWndFrom = HWnd(DllStructGetData($tInfo, "hWndFrom"))
					$iIDFrom = DllStructGetData($tInfo, "IDFrom")
					$iCode = DllStructGetData($tInfo, "Code")
					_DebugPrint("$NM_RCLICK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->ItemSpec:" & @TAB & DllStructGetData($tInfo, "ItemSpec") & @CRLF & _
							"-->ItemData:" & @TAB & DllStructGetData($tInfo, "ItemData") & @CRLF & _
							"-->X:" & @TAB & DllStructGetData($tInfo, "X") & @CRLF & _
							"-->Y:" & @TAB & DllStructGetData($tInfo, "Y") & @CRLF & _
							"-->HitInfo:" & @TAB & DllStructGetData($tInfo, "HitInfo"))
					Return True ; indicate that the mouse click was handled and suppress default processing by the system
					; Return FALSE ;to allow default processing of the click.
				Case $NM_RDBLCLK ; The user has double-clicked the right mouse button within the control
					$tInfo = DllStructCreate($tagNMMOUSE, $lParam)
					$hWndFrom = HWnd(DllStructGetData($tInfo, "hWndFrom"))
					$iIDFrom = DllStructGetData($tInfo, "IDFrom")
					$iCode = DllStructGetData($tInfo, "Code")
					_DebugPrint("$NM_RDBLCLK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->ItemSpec:" & @TAB & DllStructGetData($tInfo, "ItemSpec") & @CRLF & _
							"-->ItemData:" & @TAB & DllStructGetData($tInfo, "ItemData") & @CRLF & _
							"-->X:" & @TAB & DllStructGetData($tInfo, "X") & @CRLF & _
							"-->Y:" & @TAB & DllStructGetData($tInfo, "Y") & @CRLF & _
							"-->HitInfo:" & @TAB & DllStructGetData($tInfo, "HitInfo"))
					Return True ; indicate that the mouse click was handled and suppress default processing by the system
					; Return FALSE ;to allow default processing of the click.
				Case $SBN_SIMPLEMODECHANGE ; Simple mode changes
					_DebugPrint("$SBN_SIMPLEMODECHANGE" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; No return value
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _DebugPrint($s_Text, $sLine = @ScriptLineNumber)
	ConsoleWrite( _
			"!===========================================================" & @CRLF & _
			"+======================================================" & @CRLF & _
			"-->Line(" & StringFormat("%04d", $sLine) & "):" & @TAB & $s_Text & @CRLF & _
			"+======================================================" & @CRLF)
EndFunc   ;==>_DebugPrint
