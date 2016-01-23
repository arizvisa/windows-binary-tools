#include <GUIConstantsEx.au3>
#include <GuiRichEdit.au3>
#include <WindowsConstants.au3>

Global $g_idLblMsg, $g_hRichEdit

Example()

Func Example()
	Local $hGui, $iMsg, $iCp, $idBtnNext, $iStep = 0
	$hGui = GUICreate("Example (" & StringTrimRight(@ScriptName, StringLen(".exe")) & ")", 320, 350, -1, -1)
	$g_hRichEdit = _GUICtrlRichEdit_Create($hGui, "This is a test.", 10, 10, 300, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
	$g_idLblMsg = GUICtrlCreateLabel("", 10, 235, 300, 60)
	$idBtnNext = GUICtrlCreateButton("Next", 270, 310, 40, 30)
	GUISetState(@SW_SHOW)

	_GUICtrlRichEdit_SetText($g_hRichEdit, "First paragraph")
	Report("First paragraph")
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
						_GUICtrlRichEdit_SetParaAlignment($g_hRichEdit, "r")
						Report("First paragraph")
					Case 2
						_GUICtrlRichEdit_AppendText($g_hRichEdit, @CRLF & "Second paragraph")
						_GUICtrlRichEdit_SetParaAlignment($g_hRichEdit, "c")
						Report("Second paragraph")
					Case 3
						_GUICtrlRichEdit_AppendText($g_hRichEdit, @CRLF & "Third paragraph")
						_GUICtrlRichEdit_SetParaAlignment($g_hRichEdit, "l")
						Report("Third paragraph")
					Case 4
						$iCp = _GUICtrlRichEdit_GetFirstCharPosOnLine($g_hRichEdit, 2)
						_GUICtrlRichEdit_SetSel($g_hRichEdit, $iCp, -1)
						Report("Alignment of paragraphs in selection")
						GUICtrlSetState($idBtnNext, $GUI_DISABLE)
				EndSwitch
		EndSelect
	WEnd
EndFunc   ;==>Example

Func Report($sMsg)
	$sMsg = $sMsg & @CRLF & @CRLF & "Get function returns " & @CRLF & _GUICtrlRichEdit_GetParaAlignment($g_hRichEdit)
	GUICtrlSetData($g_idLblMsg, $sMsg)
EndFunc   ;==>Report
