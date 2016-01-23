#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $iX, $iY, $idListview

	GUICreate("ListView Get Item Position Y", 400, 300)
	$idListview = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	; Add columns
	_GUICtrlListView_AddColumn($idListview, "Items", 100)

	; Add items
	_GUICtrlListView_AddItem($idListview, "Item 1")
	_GUICtrlListView_AddItem($idListview, "Item 2")
	_GUICtrlListView_AddItem($idListview, "Item 3")

	; Get item 2 position
	$iX = _GUICtrlListView_GetItemPositionX($idListview, 1)
	$iY = _GUICtrlListView_GetItemPositionY($idListview, 1)
	MsgBox($MB_SYSTEMMODAL, "Information", StringFormat("Item 2 Position : [%d, %d]", $iX, $iY))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
