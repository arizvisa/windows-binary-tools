#include <GUIConstantsEx.au3>
#include <GuiRichEdit.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $hGui, $hRichEdit, $iMsg
	$hGui = GUICreate("Example (" & StringTrimRight(@ScriptName, StringLen(".exe")) & ")", 320, 350, -1, -1)
	$hRichEdit = _GUICtrlRichEdit_Create($hGui, "This is a test.", 10, 10, 300, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
	GUISetState(@SW_SHOW)

	_GUICtrlRichEdit_AppendText($hRichEdit, "Para with default border settings")
	MsgBox($MB_SYSTEMMODAL, "", "The default paragraph border settings are " & _GUICtrlRichEdit_GetParaBorder($hRichEdit))

	_GUICtrlRichEdit_AppendText($hRichEdit, @CRLF & "Second paragraph")
	_GUICtrlRichEdit_SetParaBorder($hRichEdit, "o", 3, "mag", 0.25)
	MsgBox($MB_SYSTEMMODAL, "", "Border settings of second paragraph are " & _GUICtrlRichEdit_GetParaBorder($hRichEdit))

	_GUICtrlRichEdit_SetSel($hRichEdit, 10, -1)
	Sleep(1000)
	MsgBox($MB_SYSTEMMODAL, "", "Border settings of first paragraph in the selection are " & _GUICtrlRichEdit_GetParaBorder($hRichEdit))

	; Change from outside border to left border
	_GUICtrlRichEdit_SetParaBorder($hRichEdit, "l")

	; Stream all text to the Desktop so you can look at border settings in Word
	_GUICtrlRichEdit_Deselect($hRichEdit)
	_GUICtrlRichEdit_StreamToFile($hRichEdit, @DesktopDir & "\gcre.rtf")

	While True
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = $GUI_EVENT_CLOSE
				_GUICtrlRichEdit_Destroy($hRichEdit) ; needed unless script crashes
				; GUIDelete() 	; is OK too
				Exit
		EndSelect
	WEnd
EndFunc   ;==>Example
