#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idListview

	GUICreate("ListView Get Counter Page", 400, 300)
	$idListview = GUICtrlCreateListView("Column 1|Column 2|Column 3", 2, 2, 394, 268)
	_GUICtrlListView_SetExtendedListViewStyle($idListview, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES))
	GUISetState(@SW_SHOW)

	; Show item count per page
	MsgBox($MB_SYSTEMMODAL, "Information", "Items per page: " & _GUICtrlListView_GetCounterPage($idListview))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
