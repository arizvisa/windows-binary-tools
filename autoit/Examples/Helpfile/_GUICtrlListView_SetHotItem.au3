#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $iStylesEx = BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES), $idListview

	GUICreate("ListView Set Hot Item", 400, 300)

	$idListview = GUICtrlCreateListView("", 2, 2, 394, 268)
	$idListview = GUICtrlGetHandle($idListview)
	_GUICtrlListView_SetExtendedListViewStyle($idListview, $iStylesEx)
	GUISetState(@SW_SHOW)

	; Add columns
	_GUICtrlListView_AddColumn($idListview, "Column 1", 100)
	_GUICtrlListView_AddColumn($idListview, "Column 2", 100)
	_GUICtrlListView_AddColumn($idListview, "Column 3", 100)

	; Add items
	_GUICtrlListView_AddItem($idListview, "Row 1: Col 1")
	_GUICtrlListView_AddSubItem($idListview, 0, "Row 1: Col 2", 1)
	_GUICtrlListView_AddSubItem($idListview, 0, "Row 1: Col 3", 2)
	_GUICtrlListView_AddItem($idListview, "Row 2: Col 1")
	_GUICtrlListView_AddSubItem($idListview, 1, "Row 2: Col 2", 1)
	_GUICtrlListView_AddItem($idListview, "Row 3: Col 1")

	; Set hot item
	_GUICtrlListView_SetHotItem($idListview, 1)
	MsgBox($MB_SYSTEMMODAL, "Information", "Hot Item: " & _GUICtrlListView_GetHotItem($idListview))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
