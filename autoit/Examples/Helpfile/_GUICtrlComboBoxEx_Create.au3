#include <GuiComboBoxEx.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $g_hCombo

Example()

Func Example()
	Local $hGUI

	; Create GUI
	$hGUI = GUICreate("ComboBoxEx Create", 400, 300)
	$g_hCombo = _GUICtrlComboBoxEx_Create($hGUI, "This is a test|Line 2", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	_GUICtrlComboBoxEx_AddString($g_hCombo, "Some More Text")
	_GUICtrlComboBoxEx_InsertString($g_hCombo, "Inserted Text", 1)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

Func WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $tInfo

	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $g_hCombo
			Switch $iCode
				Case $CBEN_BEGINEDIT ; Sent when the user activates the drop-down list or clicks in the control's edit box.
					_DebugPrint("$CBEN_BEGINEDIT" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					Return 0
				Case $CBEN_DELETEITEM
					_DebugPrint("$CBEN_DELETEITEM" & _GetComboBoxEx($lParam))
					Return 0
				Case $CBEN_DRAGBEGINA, $CBEN_DRAGBEGINW
					$tInfo = DllStructCreate($tagNMCBEDRAGBEGIN, $lParam)
					If DllStructGetData($tInfo, "ItemID") Then _DebugPrint("$CBEN_DRAGBEGIN" & _GetComboBoxEx($lParam))
					_DebugPrint("$CBEN_DRAGBEGIN" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tInfo, "hWndFrom") & @CRLF & _
							"-->IDFrom:" & @TAB & DllStructGetData($tInfo, "IDFrom") & @CRLF & _
							"-->Code:" & @TAB & DllStructGetData($tInfo, "Code") & @CRLF & _
							"-->ItemID:" & @TAB & DllStructGetData($tInfo, "ItemID") & @CRLF & _
							"-->Text:" & @TAB & DllStructGetData($tInfo, "Text"))
					; return is ignored
				Case $CBEN_ENDEDITA, $CBEN_ENDEDITW ; Sent when the user has concluded an operation within the edit box or has selected an item from the control's drop-down list.
					$tInfo = DllStructCreate($tagNMCBEENDEDIT, $lParam)
					_DebugPrint("$CBEN_ENDEDIT" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tInfo, "hWndFrom") & @CRLF & _
							"-->IDFrom:" & @TAB & DllStructGetData($tInfo, "IDFrom") & @CRLF & _
							"-->Code:" & @TAB & DllStructGetData($tInfo, "Code") & @CRLF & _
							"-->fChanged:" & @TAB & DllStructGetData($tInfo, "fChanged") & @CRLF & _
							"-->NewSelection:" & @TAB & DllStructGetData($tInfo, "NewSelection") & @CRLF & _
							"-->Text:" & @TAB & DllStructGetData($tInfo, "Text") & @CRLF & _
							"-->Why:" & @TAB & DllStructGetData($tInfo, "Why"))
					Return False ; accept the notification and allow the control to display the selected item
					; Return True  ; otherwise
				Case $CBEN_GETDISPINFOA, $CBEN_GETDISPINFOW ; Sent to retrieve display information about a callback item
					_DebugPrint("$CBEN_GETDISPINFO" & _GetComboBoxEx($lParam))
					Return 0
				Case $CBEN_INSERTITEM
					$tInfo = DllStructCreate($tagNMCOMBOBOXEX, $lParam)
					Local $tBuffer = DllStructCreate("wchar Text[" & DllStructGetData($tInfo, "TextMax") & "]", DllStructGetData($tInfo, "Text"))
					_DebugPrint("$CBEN_INSERTITEM" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tInfo, "hWndFrom") & @CRLF & _
							"-->IDFrom:" & @TAB & DllStructGetData($tInfo, "IDFrom") & @CRLF & _
							"-->Code:" & @TAB & DllStructGetData($tInfo, "Code") & @CRLF & _
							"-->Mask:" & @TAB & DllStructGetData($tInfo, "Mask") & @CRLF & _
							"-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @CRLF & _
							"-->Text:" & @TAB & DllStructGetData($tBuffer, "Text") & @CRLF & _
							"-->TextMax:" & @TAB & DllStructGetData($tInfo, "TextMax") & @CRLF & _
							"-->Indent:" & @TAB & DllStructGetData($tInfo, "Indent") & @CRLF & _
							"-->Image:" & @TAB & DllStructGetData($tInfo, "Image") & @CRLF & _
							"-->SelectedImage:" & @TAB & DllStructGetData($tInfo, "SelectedImage") & @CRLF & _
							"-->OverlayImage:" & @TAB & DllStructGetData($tInfo, "OverlayImage") & @CRLF & _
							"-->Param:" & @TAB & DllStructGetData($tInfo, "Param"))
					Return 0
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _GetComboBoxEx($lParam)
	Local $tInfo = DllStructCreate($tagNMCOMBOBOXEX, $lParam)
	Local $aItem = _GUICtrlComboBoxEx_GetItem($g_hCombo, DllStructGetData($tInfo, "Item"))
	Return @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tInfo, "hWndFrom") & @CRLF & _
			"-->IDFrom:" & @TAB & DllStructGetData($tInfo, "IDFrom") & @CRLF & _
			"-->Code:" & @TAB & DllStructGetData($tInfo, "Code") & @CRLF & _
			"-->Mask:" & @TAB & DllStructGetData($tInfo, "Mask") & @CRLF & _
			"-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @CRLF & _
			"-->Text:" & @TAB & $aItem[0] & @CRLF & _
			"-->TextMax:" & @TAB & $aItem[1] & @CRLF & _
			"-->Indent:" & @TAB & $aItem[2] & @CRLF & _
			"-->Image:" & @TAB & $aItem[3] & @CRLF & _
			"-->SelectedImage:" & @TAB & $aItem[4] & @CRLF & _
			"-->OverlayImage:" & @TAB & $aItem[5] & @CRLF & _
			"-->Param:" & @TAB & $aItem[5]
EndFunc   ;==>_GetComboBoxEx

Func _DebugPrint($s_Text, $sLine = @ScriptLineNumber)
	ConsoleWrite( _
			"!===========================================================" & @CRLF & _
			"+======================================================" & @CRLF & _
			"-->Line(" & StringFormat("%04d", $sLine) & "):" & @TAB & $s_Text & @CRLF & _
			"+======================================================" & @CRLF)
EndFunc   ;==>_DebugPrint
