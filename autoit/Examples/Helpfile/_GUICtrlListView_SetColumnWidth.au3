#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idListview

	GUICreate("ListView Set Column Width", 400, 300)
	$idListview = GUICtrlCreateListView("Column 1|Column 2|Column 3|Column 4", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	; Change column 1 width
	MsgBox($MB_SYSTEMMODAL, "Information", "Column 1 Width: " & _GUICtrlListView_GetColumnWidth($idListview, 0))
	_GUICtrlListView_SetColumnWidth($idListview, 0, 150)
	MsgBox($MB_SYSTEMMODAL, "Information", "Column 1 Width: " & _GUICtrlListView_GetColumnWidth($idListview, 0))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	GUIDelete()
EndFunc   ;==>Example
