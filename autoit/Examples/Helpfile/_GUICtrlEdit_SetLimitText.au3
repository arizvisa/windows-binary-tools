#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idEdit

	; Create GUI
	GUICreate("Edit Set Limit Text", 400, 300)
	$idEdit = GUICtrlCreateEdit("This is a test" & @CRLF & "Another Line", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	MsgBox($MB_SYSTEMMODAL, "Information", "Text Limit: " & _GUICtrlEdit_GetLimitText($idEdit))

	MsgBox($MB_SYSTEMMODAL, "Information", "Setting Text Limit")
	_GUICtrlEdit_SetLimitText($idEdit, 64000)

	MsgBox($MB_SYSTEMMODAL, "Information", "Text Limit: " & _GUICtrlEdit_GetLimitText($idEdit))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
