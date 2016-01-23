#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example() ; A ListView control created with the ListView UDF.

Func Example()
	Local $aItems[10][3]

	Local $hGUI = GUICreate("(UDF Created) ListView Delete All Items", 400, 300)
	Local $hListView = _GUICtrlListView_Create($hGUI, "col1|col2|col3", 10, 10, 380, 280)

	; Display the GUI.
	GUISetState(@SW_SHOW)

	; 3 column load
	For $i = 0 To UBound($aItems) - 1
		$aItems[$i][0] = "Item " & $i
		$aItems[$i][1] = "Item " & $i & "-1"
		$aItems[$i][2] = "Item " & $i & "-2"
	Next

	_GUICtrlListView_AddArray($hListView, $aItems)

	MsgBox($MB_SYSTEMMODAL, "Delete all", "Delete all items")

	; Pass the handle of a UDF-created ListView
	_GUICtrlListView_DeleteAllItems($hListView)

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
