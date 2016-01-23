#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $aItem, $idListview

	GUICreate("ListView Get Item", 400, 300)

	$idListview = GUICtrlCreateListView("Items", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	GUICtrlCreateListViewItem("Row 1", $idListview)
	GUICtrlCreateListViewItem("Row 2", $idListview)
	GUICtrlCreateListViewItem("Row 3", $idListview)

	; Show item 2 text
	$aItem = _GUICtrlListView_GetItem($idListview, 1)
	MsgBox($MB_SYSTEMMODAL, "Information", "Item 2 Text: " & $aItem[3])

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	GUIDelete()
EndFunc   ;==>Example
