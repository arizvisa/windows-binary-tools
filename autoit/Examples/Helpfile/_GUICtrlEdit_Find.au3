; using AutoIt Function

#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <WindowsConstants.au3>

Example_Internal()

Func Example_Internal()
	Local $s_Text = "this is a test" & @CRLF & _
			"this is only a test" & @CRLF & _
			"this testing should work for you as well as it does for me"
	Local $idButton1, $idButton2, $iMsg, $idEdit

	GUICreate('Find And Replace Example with AutoIt ' & FileGetVersion(@AutoItExe), 622, 448, 192, 125)
	$idEdit = GUICtrlCreateEdit($s_Text, 64, 24, 505, 233, _
			BitOR($ES_AUTOVSCROLL, $WS_VSCROLL, $ES_MULTILINE, $WS_HSCROLL, $ES_NOHIDESEL))
	$idButton1 = GUICtrlCreateButton("Find", 176, 288, 121, 33, 0)
	$idButton2 = GUICtrlCreateButton("Find And Replace", 368, 288, 121, 33, 0)
	GUISetState(@SW_SHOW)

	While 1
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = $GUI_EVENT_CLOSE
				ExitLoop
			Case $iMsg = $idButton1
				_GUICtrlEdit_Find($idEdit)
			Case $iMsg = $idButton2
				_GUICtrlEdit_Find($idEdit, True)
			Case Else
				;;;;;;;
		EndSelect
	WEnd
	GUIDelete()
EndFunc   ;==>Example_Internal
