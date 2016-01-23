#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI, $hEdit

	; Create GUI
	$hGUI = GUICreate("Edit Destroy", 400, 300)
	$hEdit = _GUICtrlEdit_Create($hGUI, "This is a test" & @CRLF & "Another Line", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	_GUICtrlEdit_AppendText($hEdit, @CRLF & "Append to the end?")

	MsgBox($MB_SYSTEMMODAL, "Information", "Destroy Edit Control")
	_GUICtrlEdit_Destroy($hEdit)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
