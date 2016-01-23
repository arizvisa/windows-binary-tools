#include <GUIConstantsEx.au3>
#include <GuiListView.au3>

Example()

Func Example()
	Local $idListview

	GUICreate("ListView Insert Item", 400, 300)
	$idListview = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	; Insert columns
	_GUICtrlListView_InsertColumn($idListview, 0, "Column 1", 100)

	; Add items
	_GUICtrlListView_InsertItem($idListview, "Item 1", 0)
	_GUICtrlListView_InsertItem($idListview, "Item 2", 1)
	_GUICtrlListView_InsertItem($idListview, "Item 3", 1)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
