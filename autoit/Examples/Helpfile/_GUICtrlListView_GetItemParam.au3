#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

; Warning do not use SetItemParam on items created with GUICtrlCreateListViewItem
; Param is the controlID for items created with built-in function

Example_UDF_Created()

Func Example_UDF_Created()
	Local $hGUI, $hListView

	$hGUI = GUICreate("(UDF Created) ListView Get Item Param", 400, 300)
	$hListView = _GUICtrlListView_Create($hGUI, "", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	; Add columns
	_GUICtrlListView_AddColumn($hListView, "Items", 100)

	; Add items
	_GUICtrlListView_AddItem($hListView, "Item 1")
	_GUICtrlListView_AddItem($hListView, "Item 2")
	_GUICtrlListView_AddItem($hListView, "Item 3")

	; Set item 2 parameter
	_GUICtrlListView_SetItemParam($hListView, 1, 1234)
	MsgBox($MB_SYSTEMMODAL, "Information", "Item 2 Parameter: " & _GUICtrlListView_GetItemParam($hListView, 1))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example_UDF_Created
