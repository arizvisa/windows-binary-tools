#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $iID, $idListview

	GUICreate("ListView Map Index  To ID", 400, 300)
	$idListview = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	; Add column
	_GUICtrlListView_AddColumn($idListview, "Items", 100)

	; Add items
	_GUICtrlListView_AddItem($idListview, "Item 1")
	_GUICtrlListView_AddItem($idListview, "Item 2")
	_GUICtrlListView_AddItem($idListview, "Item 3")

	; Show ID for item 2
	$iID = _GUICtrlListView_MapIndexToID($idListview, 1)
	MsgBox($MB_SYSTEMMODAL, "Information", "Index to ID: " & $iID)
	MsgBox($MB_SYSTEMMODAL, "Information", "ID to Index: " & _GUICtrlListView_MapIDToIndex($idListview, $iID))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
