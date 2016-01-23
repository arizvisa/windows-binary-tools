#include <GUIConstantsEx.au3>
#include <GuiToolbar.au3>
#include <WindowsConstants.au3>

Global $g_hToolbar, $g_idMemo
Global $g_iItem ; Command identifier of the button associated with the notification.
Global Enum $e_idNew = 1000, $e_idOpen, $e_idSave, $e_idHelp

Example()

Func Example()
	Local $hGUI, $aSize

	; Create GUI
	$hGUI = GUICreate("Toolbar", 600, 400)
	$g_hToolbar = _GUICtrlToolbar_Create($hGUI)
	$aSize = _GUICtrlToolbar_GetMaxSize($g_hToolbar)

	$g_idMemo = GUICtrlCreateEdit("", 2, $aSize[1] + 20, 596, 396 - ($aSize[1] + 20), $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)
	GUIRegisterMsg($WM_NOTIFY, "_WM_NOTIFY")

	; Add standard system bitmaps
	_GUICtrlToolbar_AddBitmap($g_hToolbar, 1, -1, $IDB_STD_LARGE_COLOR)

	; Add buttons
	_GUICtrlToolbar_AddButton($g_hToolbar, $e_idNew, $STD_FILENEW)
	_GUICtrlToolbar_AddButton($g_hToolbar, $e_idOpen, $STD_FILEOPEN)
	_GUICtrlToolbar_AddButton($g_hToolbar, $e_idSave, $STD_FILESAVE)
	_GUICtrlToolbar_AddButtonSep($g_hToolbar)
	_GUICtrlToolbar_AddButton($g_hToolbar, $e_idHelp, $STD_HELP)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Write message to memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite

; WM_NOTIFY event handler
Func _WM_NOTIFY($hWndGUI, $iMsgID, $wParam, $lParam)
	#forceref $hWndGUI, $iMsgID, $wParam
	Local $tNMHDR, $hWndFrom, $iCode, $iNew, $iFlags, $iOld
	Local $tNMTBHOTITEM
	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hWndFrom = DllStructGetData($tNMHDR, "hWndFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $g_hToolbar
			Switch $iCode
				Case $NM_LDOWN
					;----------------------------------------------------------------------------------------------
					MemoWrite("$NM_LDOWN: Clicked Item: " & $g_iItem & " at index: " & _GUICtrlToolbar_CommandToIndex($g_hToolbar, $g_iItem))
					;----------------------------------------------------------------------------------------------
				Case $TBN_HOTITEMCHANGE
					$tNMTBHOTITEM = DllStructCreate($tagNMTBHOTITEM, $lParam)
					$iOld = DllStructGetData($tNMTBHOTITEM, "idOld")
					$iNew = DllStructGetData($tNMTBHOTITEM, "idNew")
					$g_iItem = $iNew
					$iFlags = DllStructGetData($tNMTBHOTITEM, "dwFlags")
					If BitAND($iFlags, $HICF_LEAVING) = $HICF_LEAVING Then
						MemoWrite("$HICF_LEAVING: " & $iOld)
					Else
						Switch $iNew
							Case $e_idNew
								;----------------------------------------------------------------------------------------------
								MemoWrite("$TBN_HOTITEMCHANGE: $e_idNew")
								;----------------------------------------------------------------------------------------------
							Case $e_idOpen
								;----------------------------------------------------------------------------------------------
								MemoWrite("$TBN_HOTITEMCHANGE: $e_idOpen")
								;----------------------------------------------------------------------------------------------
							Case $e_idSave
								;----------------------------------------------------------------------------------------------
								MemoWrite("$TBN_HOTITEMCHANGE: $e_idSave")
								;----------------------------------------------------------------------------------------------
							Case $e_idHelp
								;----------------------------------------------------------------------------------------------
								MemoWrite("$TBN_HOTITEMCHANGE: $idHelp")
								;----------------------------------------------------------------------------------------------
						EndSwitch
					EndIf
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>_WM_NOTIFY
