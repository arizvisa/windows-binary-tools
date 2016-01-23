#include <GUIConstantsEx.au3>
#include <GuiMenu.au3>
#include <GuiRichEdit.au3>
#include <WindowsConstants.au3>

Global $g_hRichEdit, $g_idMnu, $g_idMnuUndo, $g_idMnuRedo, $g_idMnuCut, $g_idMnuCopy
Global $g_idMnuPaste, $g_idMnuPasteSpl

Example()

Func Example()
	Local $hGui, $idMnuPasteSplRTF, $idMnuPasteSplwObjs
	$hGui = GUICreate("Example (" & StringTrimRight(@ScriptName, StringLen(".exe")) & ")", 320, 350, -1, -1)
	$g_hRichEdit = _GUICtrlRichEdit_Create($hGui, "This is a test.", 10, 10, 300, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
	GUISetState(@SW_SHOW)

	_GUICtrlRichEdit_AppendText($g_hRichEdit, ReadBmpToRtf(FindFirstBMP()) & @CRLF)

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	$g_idMnu = GUICtrlCreateContextMenu(GUICtrlCreateDummy())
	$g_idMnuUndo = GUICtrlCreateMenuItem("Undo", $g_idMnu)
	$g_idMnuRedo = GUICtrlCreateMenuItem("Redo", $g_idMnu)
	GUICtrlCreateMenuItem("", $g_idMnu)
	$g_idMnuCut = GUICtrlCreateMenuItem("Cut", $g_idMnu)
	$g_idMnuCopy = GUICtrlCreateMenuItem("Copy", $g_idMnu)
	$g_idMnuPaste = GUICtrlCreateMenuItem("Paste", $g_idMnu)
	$g_idMnuPasteSpl = GUICtrlCreateMenu("Paste Special", $g_idMnu)
	$idMnuPasteSplRTF = GUICtrlCreateMenuItem("RTF only", $g_idMnuPasteSpl)
	$idMnuPasteSplwObjs = GUICtrlCreateMenuItem("With objects", $g_idMnuPasteSpl)
	_GUICtrlRichEdit_SetEventMask($g_hRichEdit, $ENM_MOUSEEVENTS)

	While True
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				_GUICtrlRichEdit_Destroy($g_hRichEdit) ; needed unless script crashes
				; GUIDelete() 	; is OK too
				Exit
			Case $g_idMnuUndo
				_GUICtrlRichEdit_Undo($g_hRichEdit)
			Case $g_idMnuRedo
				_GUICtrlRichEdit_Redo($g_hRichEdit)
			Case $g_idMnuCut
				_GUICtrlRichEdit_Cut($g_hRichEdit)
			Case $g_idMnuCopy
				_GUICtrlRichEdit_Copy($g_hRichEdit)
			Case $g_idMnuPaste
				_GUICtrlRichEdit_Paste($g_hRichEdit)
			Case $idMnuPasteSplRTF
				_GUICtrlRichEdit_PasteSpecial($g_hRichEdit, False)
			Case $idMnuPasteSplwObjs
				_GUICtrlRichEdit_PasteSpecial($g_hRichEdit, True)
		EndSwitch
	WEnd
EndFunc   ;==>Example

Func WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	Local $hWndFrom, $iCode, $tNMHDR, $tMsgFilter, $hMenu
	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $g_hRichEdit
			Select
				Case $iCode = $EN_MSGFILTER
					$tMsgFilter = DllStructCreate($tagMSGFILTER, $lParam)
					If DllStructGetData($tMsgFilter, "msg") = $WM_RBUTTONUP Then
						$hMenu = GUICtrlGetHandle($g_idMnu)
						SetMenuTexts($hWndFrom, $hMenu)
						_GUICtrlMenu_TrackPopupMenu($hMenu, $hWnd)
					EndIf
			EndSelect
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func SetMenuTexts($hWnd, $hMenu)
	Local $fState
	If _GUICtrlRichEdit_CanUndo($hWnd) Then
		_GUICtrlMenu_SetItemEnabled($hMenu, $g_idMnuUndo, True, False)
		_GUICtrlMenu_SetItemText($hMenu, $g_idMnuUndo, "Undo: " & _GUICtrlRichEdit_GetNextUndo($hWnd), False)
	Else
		_GUICtrlMenu_SetItemText($hMenu, $g_idMnuUndo, "Undo", False)
		_GUICtrlMenu_SetItemEnabled($hMenu, $g_idMnuUndo, False, False)
	EndIf
	If _GUICtrlRichEdit_CanRedo($hWnd) Then
		_GUICtrlMenu_SetItemEnabled($hMenu, $g_idMnuRedo, True, False)
		_GUICtrlMenu_SetItemText($hMenu, $g_idMnuRedo, "Redo: " & _GUICtrlRichEdit_GetNextRedo($hWnd), False)
	Else
		_GUICtrlMenu_SetItemText($hMenu, $g_idMnuRedo, "Redo", False)
		_GUICtrlMenu_SetItemEnabled($hMenu, $g_idMnuRedo, False, False)
	EndIf
	$fState = _GUICtrlRichEdit_IsTextSelected($hWnd)
	_GUICtrlMenu_SetItemEnabled($hMenu, $g_idMnuCut, $fState, False)
	_GUICtrlMenu_SetItemEnabled($hMenu, $g_idMnuCopy, $fState, False)

	_GUICtrlMenu_SetItemEnabled($hMenu, $g_idMnuPaste, _GUICtrlRichEdit_CanPaste($hWnd))

	_GUICtrlMenu_SetItemEnabled($hMenu, $g_idMnuPasteSpl, _GUICtrlRichEdit_CanPasteSpecial($hWnd), False)
EndFunc   ;==>SetMenuTexts

Func ReadBmpToRtf($sBmpFilspc)
	Local $hFile, $sRtf
	$hFile = FileOpen($sBmpFilspc, 16)
	If FileRead($hFile, 2) <> "0x424D" Then Return SetError(1, 0, "")
	FileRead($hFile, 12)
	$sRtf = '{\rtf1{\pict\dibitmap ' & Hex(FileRead($hFile)) & '}}'
	FileClose($hFile)
	Return $sRtf
EndFunc   ;==>ReadBmpToRtf

Func FindFirstBMP($sPath = @WindowsDir)
	Local $hFind, $sBmpFilspc
	$hFind = FileFindFirstFile($sPath & "\*.bmp")
	$sBmpFilspc = FileFindNextFile($hFind)
	FileClose($hFind)
	Return $sPath & "\" & $sBmpFilspc
EndFunc   ;==>FindFirstBMP
