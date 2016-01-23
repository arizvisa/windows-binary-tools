#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idListview

	GUICreate("ListView Set Item", 400, 300)
	$idListview = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	; Add columns
	_GUICtrlListView_AddColumn($idListview, "Items", 100)

	; Add items
	GUICtrlCreateListViewItem("Item 1", $idListview)
	GUICtrlCreateListViewItem("Item 2", $idListview)
	GUICtrlCreateListViewItem("Item 3", $idListview)

	; Change item 2
	MsgBox($MB_SYSTEMMODAL, "Information", "Changing item 2")
	_GUICtrlListView_SetItem($idListview, "New Item 2", 1)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
