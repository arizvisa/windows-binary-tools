#include <APIDlgConstants.au3>
#include <FontConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIRichEdit.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIDlg.au3>
#include <WindowsConstants.au3>

Local Const $e_sText = 'AutoIt v3 is a freeware BASIC-like scripting language designed for automating the Windows GUI and general scripting. It uses a combination of simulated keystrokes, mouse movement and window/control manipulation in order to automate tasks in a way not possible or reliable with other languages (e.g. VBScript and SendKeys). AutoIt is also very small, self-contained and will run on all versions of Windows out-of-the-box with no annoying "runtimes" required!' & @CRLF & @CRLF & _
		'AutoIt was initially designed for PC "roll out" situations to reliably automate and configure thousands of PCs. Over time it has become a powerful language that supports complex expressions, user functions, loops and everything else that veteran scripters would expect.'

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 800, 600)

; Create main menu
Local $idMenu = GUICtrlCreateMenu('&File')
Local $idExitItem = GUICtrlCreateMenuItem('E&xit...', $idMenu)
$idMenu = GUICtrlCreateMenu('&Edit')
Local $idFindItem = GUICtrlCreateMenuItem('&Find...', $idMenu)
Local $idReplaceItem = GUICtrlCreateMenuItem('R&eplace...', $idMenu)

; Create Rich Edit control with always visible text selection, and set "Courier New" font to the control
Local $hRichEdit = _GUICtrlRichEdit_Create($hForm, $e_sText, 0, 0, 800, 600, BitOR($ES_AUTOVSCROLL, $ES_NOHIDESEL, $ES_MULTILINE, $WS_VSCROLL), 0)
Local $hFont = _WinAPI_CreateFont(17, 0, 0, 0, $FW_NORMAL, 0, 0, 0, $DEFAULT_CHARSET, $OUT_DEFAULT_PRECIS, $CLIP_DEFAULT_PRECIS, $ANTIALIASED_QUALITY, $DEFAULT_PITCH, 'Courier New')
_SendMessage($hRichEdit, $WM_SETFONT, $hFont, 1)
_SendMessage($hRichEdit, $EM_SETSEL)

; Register FINDMSGSTRING message to receive the messages from the dialog box
GUIRegisterMsg(_WinAPI_RegisterWindowMessage('commdlg_FindReplace'), 'WM_FINDMSGSTRING')

; Show GUI
GUISetState(@SW_SHOW)

Global $g_hDlg
Local $iMsg, $sText
While 1
	$iMsg = GUIGetMsg()
	Switch $iMsg
		Case $GUI_EVENT_CLOSE, $idExitItem
			ExitLoop
		Case $idFindItem, $idReplaceItem
			$sText = _GUICtrlRichEdit_GetSelText($hRichEdit)
			If @error Then
				$sText = ''
			EndIf
			; Disable "Find..." and "Replace..." menu items, otherwise, the script maay crash
			GUICtrlSetState($idFindItem, $GUI_DISABLE)
			GUICtrlSetState($idReplaceItem, $GUI_DISABLE)
			Switch $iMsg
				Case $idFindItem
					$g_hDlg = _WinAPI_FindTextDlg($hForm, $sText, $FR_DOWN, 0, $hRichEdit)
				Case $idReplaceItem
					$g_hDlg = _WinAPI_ReplaceTextDlg($hForm, $sText, '', 0, 0, $hRichEdit)
			EndSwitch
		Case $idReplaceItem
	EndSwitch
WEnd

GUIDelete()

Func _IsMatchSelection($hWnd, $sText, $iBehavior)
	Local $aPos = _GUICtrlRichEdit_GetSel($hWnd)
	If @error Then Return 0

	$aPos = _GUICtrlRichEdit_FindTextInRange($hWnd, $sText, $aPos[0], $aPos[1], BitAND($iBehavior, $FR_MATCHCASE) = $FR_MATCHCASE, BitAND($iBehavior, $FR_WHOLEWORD) = $FR_WHOLEWORD, BitAND($iBehavior, BitOR($FR_MATCHALEFHAMZA, $FR_MATCHDIAC, $FR_MATCHKASHIDA)))
	If @error Or ($aPos[0] = -1) Or ($aPos[1] = -1) Then
		Return 0
	Else
		Return 1
	EndIf
EndFunc   ;==>_IsMatchSelection

Func WM_FINDMSGSTRING($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam

	Local $tFINDREPLACE = DllStructCreate($tagFINDREPLACE, $lParam)
	Local $sReplace = _WinAPI_GetString(DllStructGetData($tFINDREPLACE, 'ReplaceWith'))
	Local $sFind = _WinAPI_GetString(DllStructGetData($tFINDREPLACE, 'FindWhat'))
	Local $hRichEdit = Ptr(DllStructGetData($tFINDREPLACE, 'lParam'))
	Local $iFlags = DllStructGetData($tFINDREPLACE, 'Flags')
	Local $aPos, $iCur = -1

	Select
		; The user clicked the "Replace" button in a Replace dialog box
		Case BitAND($iFlags, $FR_REPLACE)
			If _IsMatchSelection($hRichEdit, $sFind, $iFlags) Then
				_GUICtrlRichEdit_ReplaceText($hRichEdit, $sReplace)
			EndIf
			ContinueCase
			; The user clicked the "Find Next" button in a Find or Replace dialog box
		Case BitAND($iFlags, $FR_FINDNEXT)
			$aPos = _GUICtrlRichEdit_GetSel($hRichEdit)
			If @error Then Return

			If BitAND($iFlags, $FR_DOWN) Then
				$aPos = _GUICtrlRichEdit_FindTextInRange($hRichEdit, $sFind, $aPos[1], -1, BitAND($iFlags, $FR_MATCHCASE) = $FR_MATCHCASE, BitAND($iFlags, $FR_WHOLEWORD) = $FR_WHOLEWORD)
			Else
				$aPos = _GUICtrlRichEdit_FindTextInRange($hRichEdit, $sFind, $aPos[0], 0, BitAND($iFlags, $FR_MATCHCASE) = $FR_MATCHCASE, BitAND($iFlags, $FR_WHOLEWORD) = $FR_WHOLEWORD, BitAND($iFlags, $FR_DOWN))
			EndIf
			If @error Or ($aPos[0] = -1) Or ($aPos[1] = -1) Then
				Local $iError = @error
				MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), WinGetTitle($g_hDlg), 'Cannot find "' & $sFind & '" (' & $iError & ')', 0, $g_hDlg)
				Return
			EndIf
			; Here and below used the EM_SETSEL message directly because _GUICtrlRichEdit_SetSel() sets a focus to the Rich Edit control
			_SendMessage($hRichEdit, $EM_SETSEL, $aPos[0], $aPos[1])
			;			_GUICtrlRichEdit_ScrollToCaret($hRichEdit)
			; The user clicked the "Replace All" button in a Replace dialog box
		Case BitAND($iFlags, $FR_REPLACEALL)
			Dim $aPos[2] = [0, -1]
			While 1
				$aPos = _GUICtrlRichEdit_FindTextInRange($hRichEdit, $sFind, $aPos[0], -1, BitAND($iFlags, $FR_MATCHCASE) = $FR_MATCHCASE, BitAND($iFlags, $FR_WHOLEWORD) = $FR_WHOLEWORD)
				If ($aPos[0] = -1) Or ($aPos[1] = -1) Then
					If $iCur = -1 Then
						MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), WinGetTitle($g_hDlg), 'Cannot find "' & $sFind & '"', 0, $g_hDlg)
						Return
					EndIf
					ExitLoop
				EndIf
				If $iCur = -1 Then
					_GUICtrlRichEdit_PauseRedraw($hRichEdit)
				EndIf
				_SendMessage($hRichEdit, $EM_SETSEL, $aPos[0], $aPos[1])
				If _GUICtrlRichEdit_ReplaceText($hRichEdit, $sReplace) Then
					$iCur = $aPos[0] + StringLen($sReplace)
				Else
					ExitLoop
				EndIf
			WEnd
			_SendMessage($hRichEdit, $EM_SETSEL, $iCur, $iCur)
			;			_GUICtrlRichEdit_ScrollToCaret($hRichEdit)
			_GUICtrlRichEdit_ResumeRedraw($hRichEdit)
			; The dialog box is closing
		Case BitAND($iFlags, $FR_DIALOGTERM)
			; Destroy internal buffer, and free allocated memory
			_WinAPI_FlushFRBuffer()
			; Enable "Find..." and "Replace..." menu items
			GUICtrlSetState($idReplaceItem, $GUI_ENABLE)
			GUICtrlSetState($idFindItem, $GUI_ENABLE)
	EndSelect
EndFunc   ;==>WM_FINDMSGSTRING
