#include <GUIConstantsEx.au3>
#include <GuiRichEdit.au3>
#include <WindowsConstants.au3>

Global $g_idLblMsg, $g_hRichEdit

Example()

Func Example()
	Local $hGui, $iMsg, $idBtnNext, $iStep = 0
	$hGui = GUICreate("Example (" & StringTrimRight(@ScriptName, StringLen(".exe")) & ")", 320, 350, -1, -1)
	$g_hRichEdit = _GUICtrlRichEdit_Create($hGui, "", 10, 10, 300, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
	$g_idLblMsg = GUICtrlCreateLabel("", 10, 235, 300, 60)
	$idBtnNext = GUICtrlCreateButton("Next", 270, 310, 40, 30)
	GUISetState(@SW_SHOW)

	_GUICtrlRichEdit_SetText($g_hRichEdit, "Paragraph 1")
	For $i = 2 To 20
		_GUICtrlRichEdit_AppendText($g_hRichEdit, @CRLF & "Paragraph " & $i)
	Next
	Report("0. Initially scrolled to show insertion point")

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
						_GUICtrlRichEdit_SetScrollPos($g_hRichEdit, 0, 0)
						Report("1. Scrolled to top")
					Case 2
						_GUICtrlRichEdit_SetScrollPos($g_hRichEdit, 7, 22)
						Report("2. Scrolled down a bit, and to the right")
						GUICtrlSetState($idBtnNext, $GUI_DISABLE)
				EndSwitch
		EndSelect
	WEnd
EndFunc   ;==>Example

Func Report($sMsg)
	Local $aPos = _GUICtrlRichEdit_GetScrollPos($g_hRichEdit)
	$sMsg = $sMsg & @CRLF & "Get function returns " & $aPos[0] & ";" & $aPos[1]
	GUICtrlSetData($g_idLblMsg, $sMsg)
EndFunc   ;==>Report
