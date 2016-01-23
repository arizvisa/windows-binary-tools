#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>

Example()

Func Example()
	Local $hGui, $hEdit, $sTitle = "ShowBalloonTip", $sText = "Displays a balloon tip associated with an edit control"

	; Create GUI
	$hGui = GUICreate("Edit ShowBalloonTip", 400, 300)
	$hEdit = _GUICtrlEdit_Create($hGui, "", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	; Set Text
	_GUICtrlEdit_SetText($hEdit, "This is a test" & @CRLF & "Another Line" & @CRLF & "Append to the end?" & @CRLF & @CRLF)

	_GUICtrlEdit_ShowBalloonTip($hEdit, $sTitle, $sText, $TTI_INFO)
	Sleep(1000)
	Local $idBalloon = _GUICtrlEdit_HideBalloonTip($hEdit)
	_GUICtrlEdit_AppendText($hEdit, "HideBalloonTip = " & $idBalloon & @CRLF)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
