#include <GUIConstantsEx.au3>
#include <GuiRichEdit.au3>
#include <WindowsConstants.au3>

Global $g_idLblMsg, $g_hRichEdit

Example()

Func Example()
	Local $hGui, $iMsg, $idBtnNext, $iStep = 0, $iCp1
	$hGui = GUICreate("Example (" & StringTrimRight(@ScriptName, StringLen(".exe")) & ")", 320, 350, -1, -1)
	$g_hRichEdit = _GUICtrlRichEdit_Create($hGui, "This is a test.", 10, 10, 300, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL, $ES_NOHIDESEL))
	$g_idLblMsg = GUICtrlCreateLabel("", 10, 235, 300, 60)
	$idBtnNext = GUICtrlCreateButton("Next", 270, 310, 40, 30)
	GUISetState(@SW_SHOW)

	While True
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = $GUI_EVENT_CLOSE
				_GUICtrlRichEdit_Destroy($g_hRichEdit) ; needed unless script crashes
				; GUIDelete() 	; is OK too
				Exit
			Case $iMsg = $idBtnNext
				$iStep += 1
				Switch $iStep
					Case 1
						_GUICtrlRichEdit_SetSel($g_hRichEdit, 0, 3)
						Report("1. Initial Character attributes at start of line 1 are")
					Case 2
						_GUICtrlRichEdit_AutoDetectURL($g_hRichEdit, True)
						_GUICtrlRichEdit_AppendText($g_hRichEdit, @CRLF & "http://www.autoitscript.com")
						$iCp1 = _GUICtrlRichEdit_GetFirstCharPosOnLine($g_hRichEdit, 2)
						_GUICtrlRichEdit_SetSel($g_hRichEdit, $iCp1, $iCp1 + 3)
						Report("2. Character attributes at start of line 2 are")
						GUICtrlSetState($idBtnNext, $GUI_DISABLE)
				EndSwitch
		EndSelect
	WEnd
EndFunc   ;==>Example

Func Report($sMsg)
	Local $sRet = _GUICtrlRichEdit_GetCharAttributes($g_hRichEdit)
	$sMsg = $sMsg & @CRLF & @CRLF & "Char Attributes=" & $sRet
	GUICtrlSetData($g_idLblMsg, $sMsg)
EndFunc   ;==>Report
