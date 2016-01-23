#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idListview

	GUICreate("ListView Get Selected Column", 400, 300)
	$idListview = GUICtrlCreateListView("Column 1|Column 2|Column 3", 2, 2, 394, 268)
	GUICtrlCreateListViewItem("line1|data1|more1", $idListview)
	GUICtrlCreateListViewItem("line2|data2|more2", $idListview)
	GUICtrlCreateListViewItem("line3|data3|more3", $idListview)
	GUICtrlCreateListViewItem("line4|data4|more4", $idListview)
	GUICtrlCreateListViewItem("line5|data5|more5", $idListview)
	GUISetState(@SW_SHOW)

	; Select column 2
	_GUICtrlListView_SetSelectedColumn($idListview, 1)
	MsgBox($MB_SYSTEMMODAL, "Information", "Selected Column: " & _GUICtrlListView_GetSelectedColumn($idListview))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
