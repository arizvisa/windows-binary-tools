#include <GUIConstantsEx.au3>
#include <GuiRichEdit.au3>
#include <WindowsConstants.au3>

Global $g_idLblMsg

Example()

Func Example()
	Local $hGui, $iMsg, $idBtnNext, $hRichEdit, $iCp = -1, $s
	$hGui = GUICreate("Example (" & StringTrimRight(@ScriptName, StringLen(".exe")) & ")", 320, 350, -1, -1)
	$hRichEdit = _GUICtrlRichEdit_Create($hGui, "This is a test.", 10, 10, 300, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
	$g_idLblMsg = GUICtrlCreateLabel("", 10, 235, 300, 60)
	$idBtnNext = GUICtrlCreateButton("Next", 270, 310, 40, 30)
	GUISetState(@SW_SHOW)

	$s = Chr(9)
	For $i = 32 To 126
		$s &= Chr($i)
	Next
	_GUICtrlRichEdit_AppendText($hRichEdit, $s & @CRLF)
	_GUICtrlRichEdit_AppendText($hRichEdit, "AutoIt v3 is a (freeware) BASIC-like scripting language designed for " _
			 & "automating the Windows GUI and general scripting.")
	_GUICtrlRichEdit_AppendText($hRichEdit, @CRLF & "Another paragraph")
	While True
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = $GUI_EVENT_CLOSE
				_GUICtrlRichEdit_Destroy($hRichEdit) ; needed unless script crashes
				; GUIDelete() 	; is OK too
				Exit
			Case $iMsg = $idBtnNext
				$iCp += 1
				_GUICtrlRichEdit_GotoCharPos($hRichEdit, $iCp)
				GUICtrlSetData($g_idLblMsg, _GUICtrlRichEdit_GetCharWordBreakInfo($hRichEdit, $iCp))
		EndSelect
	WEnd
EndFunc   ;==>Example

Func Report($sMsg)
	GUICtrlSetData($g_idLblMsg, $sMsg)
EndFunc   ;==>Report

Func GetWord($hWnd, $iCp, $bForward, $bStartOfWord, $bClass = False)
	Local $iRet, $wParam
	If $bClass Then
		If $bForward Then
			$wParam = $WB_MOVEWORDRIGHT
		Else
			$wParam = $WB_MOVEWORDLEFT
		EndIf
	Else
		If $bForward Then
			If $bStartOfWord Then
				$wParam = $WB_RIGHT
			Else
				$wParam = $WB_LEFT
			EndIf
		Else
			If $bStartOfWord Then
				$wParam = $WB_RIGHTBREAK
			Else
				$wParam = $wb_LEFTBREAK
			EndIf
		EndIf
	EndIf
	$iRet = _SendMessage($hWnd, $EM_FINDWORDBREAK, $wParam, $iCp)
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $wParam = ' & $wParam & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
	Return $iRet
EndFunc   ;==>GetWord
