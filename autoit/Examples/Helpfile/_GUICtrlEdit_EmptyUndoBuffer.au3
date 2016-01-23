#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idEdit

	; Create GUI
	GUICreate("Edit Empty Undo Buffer", 400, 300)
	$idEdit = GUICtrlCreateEdit("This is a test" & @CRLF & "Another Line", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	_GUICtrlEdit_AppendText($idEdit, @CRLF & "Append to the end?")

	MsgBox($MB_SYSTEMMODAL, "Information", "Can Undo: " & _GUICtrlEdit_CanUndo($idEdit))

	_GUICtrlEdit_EmptyUndoBuffer($idEdit)

	MsgBox($MB_SYSTEMMODAL, "Information", "Can Undo: " & _GUICtrlEdit_CanUndo($idEdit))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
