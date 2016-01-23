#include <GUIConstantsEx.au3>
#include <GuiRichEdit.au3>
#include <WindowsConstants.au3>

Global $g_idLblMsg, $g_hRichEdit

Example()

Func Example()
	Local $hGui, $iMsg, $idBtnNext, $iStep = 0
	$hGui = GUICreate("Example (" & StringTrimRight(@ScriptName, StringLen(".exe")) & ")", 320, 350, -1, -1)
	$g_hRichEdit = _GUICtrlRichEdit_Create($hGui, "This is a test.", 10, 10, 300, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
	$g_idLblMsg = GUICtrlCreateLabel("", 10, 235, 300, 60)
	$idBtnNext = GUICtrlCreateButton("Next", 270, 310, 40, 30)
	GUISetState(@SW_SHOW)

	For $i = 1 To 20
		_GUICtrlRichEdit_AppendText($g_hRichEdit, "Line " & $i & @CRLF)
	Next
	_GUICtrlRichEdit_AppendText($g_hRichEdit, "Line 21")

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
						DoIt("lu", "Scrolled up a line")
					Case 2
						DoIt("pu", "Scrolled up a page")
					Case 3
						DoIt("pd", "Scrolled down a page")
					Case 4
						DoIt("pd", "Tried to scroll down another page")
						GUICtrlSetState($idBtnNext, $GUI_DISABLE)
				EndSwitch
		EndSelect
	WEnd
EndFunc   ;==>Example

Func DoIt($sAction, $sMsg)
	Local $iQlines
	$iQlines = _GUICtrlRichEdit_ScrollLineOrPage($g_hRichEdit, $sAction)
	GUICtrlSetData($g_idLblMsg, $sMsg & @CRLF & @CRLF & "Actually scrolled " & @CRLF & $iQlines & " lines")
EndFunc   ;==>DoIt
