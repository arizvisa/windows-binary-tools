#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	GUICreate("ListView Item Deletion", 400, 500)
	Local $idListview = GUICtrlCreateListView("Col 1               |Col 2      |Col 3      ", 10, 10, 380, 480, $LVS_SHOWSELALWAYS)

	; Display the GUI.
	GUISetState(@SW_SHOW)

	For $i = 0 To 9
		GUICtrlCreateListViewItem("Native Item " & $i & "|Item " & $i & "-1|Item " & $i & "-2", $idListview)
	Next
	For $i = 10 To 20
		_GUICtrlListView_AddItem($idListview, "UDF Item " & $i, -1, 1000 + $i)
		_GUICtrlListView_AddSubItem($idListview, $i, "Item " & $i & "-1", 1)
		_GUICtrlListView_AddSubItem($idListview, $i, "Item " & $i & "-2", 2)
	Next

	MsgBox($MB_SYSTEMMODAL, "Delete all", "Deleting both native and UDF Items")

	; Pass the controlID of a native-created ListView
	_GUICtrlListView_DeleteAllItems($idListview)

	; Loop until the user exits
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd

	; Delete the previous GUI and all controls.
	GUIDelete()
EndFunc   ;==>Example
