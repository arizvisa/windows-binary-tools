#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idListview

	GUICreate("ListView Get Item Count", 400, 300)
	$idListview = GUICtrlCreateListView("col1|col2|col3", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	GUICtrlCreateListViewItem("line1|data1|more1", $idListview)
	GUICtrlCreateListViewItem("line2|data2|more2", $idListview)
	GUICtrlCreateListViewItem("line3|data3|more3", $idListview)
	GUICtrlCreateListViewItem("line4|data4|more4", $idListview)
	GUICtrlCreateListViewItem("line5|data5|more5", $idListview)

	MsgBox($MB_SYSTEMMODAL, "Information", "Item Count: " & _GUICtrlListView_GetItemCount($idListview))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	GUIDelete()
EndFunc   ;==>Example
