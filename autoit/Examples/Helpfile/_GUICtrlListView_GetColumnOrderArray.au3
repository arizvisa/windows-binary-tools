#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $a_Order[5] = [4, 3, 2, 0, 1], $idListview

	GUICreate("(Internal) ListView Get Column Order Array", 400, 325)
	$idListview = GUICtrlCreateListView("Column 1|Column 2|Column 3|Column 4", 2, 2, 394, 268)
	_GUICtrlListView_SetExtendedListViewStyle($idListview, $LVS_EX_HEADERDRAGDROP)
	_GUICtrlListView_SetColumnWidth($idListview, 0, 100)
	_GUICtrlListView_SetColumnWidth($idListview, 1, 100)
	_GUICtrlListView_SetColumnWidth($idListview, 2, 100)
	_GUICtrlListView_SetColumnWidth($idListview, 3, 100)
	GUISetState(@SW_SHOW)

	_GUICtrlListView_SetColumnOrderArray($idListview, $a_Order)

	$a_Order = _GUICtrlListView_GetColumnOrderArray($idListview)
	MsgBox($MB_SYSTEMMODAL, "Information", StringFormat("Column order: [%d, %d, %d, %d]", $a_Order[1], $a_Order[2], $a_Order[3], $a_Order[4]))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
