#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idListview

	GUICreate("ListView Ensure Visible", 400, 300)
	$idListview = GUICtrlCreateListView("Items", 2, 2, 394, 268)
	_GUICtrlListView_SetColumnWidth($idListview, 0, 100)
	_GUICtrlListView_SetExtendedListViewStyle($idListview, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT))
	GUISetState(@SW_SHOW)

	_GUICtrlListView_BeginUpdate($idListview)
	For $i = 1 To 100
		GUICtrlCreateListViewItem("Item " & $i, $idListview)
	Next
	_GUICtrlListView_EndUpdate($idListview)

	MsgBox($MB_SYSTEMMODAL, "Information", "Making item 50 visible")
	_GUICtrlListView_EnsureVisible($idListview, 49)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
