#include <GUIConstantsEx.au3>
#include <GuiListView.au3>

Example()

Func Example()
	Local $idListview

	GUICreate("ListView Insert Column", 400, 300)
	$idListview = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	; Insert columns
	_GUICtrlListView_InsertColumn($idListview, 0, "Column 1", 100)
	_GUICtrlListView_InsertColumn($idListview, 1, "Column 2", 100)
	_GUICtrlListView_InsertColumn($idListview, 2, "Column 3", 100)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
