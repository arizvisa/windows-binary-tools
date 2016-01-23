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

	_GUICtrlRichEdit_SetText($g_hRichEdit, "First paragraph")
	_GUICtrlRichEdit_AppendText($g_hRichEdit, @CRLF & "Second paragraph")

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
						Report("1. Default settings ")
					Case 2
						_GUICtrlRichEdit_SetRECT($g_hRichEdit, 10, 10, 100, 100)
						Report("2. Settings ")
					Case 3
						_GUICtrlRichEdit_SetRECT($g_hRichEdit)
						Report("3. ReSettings to default")
						GUICtrlSetState($idBtnNext, $GUI_DISABLE)
				EndSwitch
		EndSelect
	WEnd
EndFunc   ;==>Example

Func Report($sMsg)
	Local $aRect = _GUICtrlRichEdit_GetRECT($g_hRichEdit)
	$sMsg = $sMsg & @CRLF & @CRLF & "Left=" & $aRect[0] & " Top=" & $aRect[1] & " Right=" & $aRect[2] & " Bottom=" & $aRect[3]
	GUICtrlSetData($g_idLblMsg, $sMsg)
EndFunc   ;==>Report
