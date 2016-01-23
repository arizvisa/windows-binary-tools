#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $tItem, $idListview

	GUICreate("ListView Get ItemEX", 400, 300)

	$idListview = GUICtrlCreateListView("Items", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	GUICtrlCreateListViewItem("Item 1", $idListview)
	GUICtrlCreateListViewItem("Item 2", $idListview)
	GUICtrlCreateListViewItem("Item 3", $idListview)

	; Show item 1 raw state
	$tItem = DllStructCreate($tagLVITEM)
	DllStructSetData($tItem, "Mask", $LVIF_STATE)
	DllStructSetData($tItem, "Item", 1)
	DllStructSetData($tItem, "StateMask", -1)
	_GUICtrlListView_GetItemEx($idListview, $tItem)
	MsgBox($MB_SYSTEMMODAL, "Information", "Item 2 State: " & DllStructGetData($tItem, "State"))

	; Select item 2
	_GUICtrlListView_SetItemSelected($idListview, 1)

	; Show item 1 raw state
	_GUICtrlListView_GetItemEx($idListview, $tItem)
	MsgBox($MB_SYSTEMMODAL, "Information", "Item 2 State: " & DllStructGetData($tItem, "State"))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
