#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>

Example()

Func Example()
	Local $idEdit, $sTitle = "ShowBalloonTip", $sText = "Displays a balloon tip associated with an edit control"

	; Create GUI
	GUICreate("Edit ShowBalloonTip", 400, 300)
	$idEdit = GUICtrlCreateEdit("", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	; Set Text
	_GUICtrlEdit_SetText($idEdit, "This is a test" & @CRLF & "Another Line" & @CRLF & "Append to the end?")

	_GUICtrlEdit_ShowBalloonTip($idEdit, $sTitle, $sText, $TTI_INFO)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
