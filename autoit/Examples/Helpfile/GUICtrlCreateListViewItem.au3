#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	GUICreate("listview items", 220, 250, 100, 200, -1, $WS_EX_ACCEPTFILES)
	GUISetBkColor(0x00E0FFFF) ; will change background color

	Local $idListview = GUICtrlCreateListView("col1  |col2|col3  ", 10, 10, 200, 150) ;,$LVS_SORTDESCENDING)
	Local $idButton = GUICtrlCreateButton("Value?", 75, 170, 70, 20)
	Local $idItem1 = GUICtrlCreateListViewItem("item2|col22|col23", $idListview)
	Local $idItem2 = GUICtrlCreateListViewItem("............item1|col12|col13", $idListview)
	Local $idItem3 = GUICtrlCreateListViewItem("item3|col32|col33", $idListview)
	GUICtrlCreateInput("", 20, 200, 150)
	GUICtrlSetState(-1, $GUI_DROPACCEPTED) ; to allow drag and dropping
	GUISetState(@SW_SHOW)
	GUICtrlSetData($idItem2, "|ITEM1")
	GUICtrlSetData($idItem3, "||COL33")
	GUICtrlDelete($idItem1)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $idButton
				MsgBox($MB_SYSTEMMODAL, "listview item", GUICtrlRead(GUICtrlRead($idListview)), 2)
			Case $idListview
				MsgBox($MB_SYSTEMMODAL, "listview", "clicked=" & GUICtrlGetState($idListview), 2)
		EndSwitch
	WEnd
EndFunc   ;==>Example
