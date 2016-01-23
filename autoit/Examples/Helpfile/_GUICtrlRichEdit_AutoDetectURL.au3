#include <GUIConstantsEx.au3>
#include <GuiRichEdit.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Global $g_hRichEdit

Example()

Func Example()
	Local $hGui, $iMsg
	$hGui = GUICreate("Example (" & StringTrimRight(@ScriptName, StringLen(".exe")) & ")", 320, 350, -1, -1)
	$g_hRichEdit = _GUICtrlRichEdit_Create($hGui, "This is a test.", 10, 10, 300, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
	GUISetState(@SW_SHOW)

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
	_GUICtrlRichEdit_SetEventMask($g_hRichEdit, $ENM_LINK)

	_GUICtrlRichEdit_AutoDetectURL($g_hRichEdit, True)
	_GUICtrlRichEdit_AppendText($g_hRichEdit, @CRLF & "http://www.autoitscript.com")
	While True
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = $GUI_EVENT_CLOSE
				_GUICtrlRichEdit_Destroy($g_hRichEdit) ; needed unless script crashes
				; GUIDelete() 	; is OK too
				Exit
		EndSelect
	WEnd
EndFunc   ;==>Example

Func WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam
	Local $hWndFrom, $iCode, $tNMHDR, $tEnLink, $iCpMin, $iCpMax, $tMsgFilter
	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $g_hRichEdit
			Select
				Case $iCode = $EN_LINK
					$tMsgFilter = DllStructCreate($tagMSGFILTER, $lParam)
					If DllStructGetData($tMsgFilter, "msg") = $WM_LBUTTONUP Then
						$tEnLink = DllStructCreate($tagENLINK, $lParam)
						$iCpMin = DllStructGetData($tEnLink, "cpMin")
						$iCpMax = DllStructGetData($tEnLink, "cpMax")
						MsgBox($MB_SYSTEMMODAL, "", "Invoke your web browser here and point it to " & _
								_GUICtrlRichEdit_GetTextInRange($g_hRichEdit, $iCpMin, $iCpMax))
					EndIf
			EndSelect
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY
