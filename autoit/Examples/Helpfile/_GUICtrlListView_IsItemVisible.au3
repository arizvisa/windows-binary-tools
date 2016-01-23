#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idListview, $iMsg, $iIndex

	GUICreate("listview items", 220, 250, 100, 200)
	GUISetBkColor(0x00E0FFFF) ; will change background color

	$idListview = GUICtrlCreateListView("col1  |col2|col3  ", 10, 10, 200, 150) ; ,$LVS_SORTDESCENDING)
	For $x = 1 To 30
		GUICtrlCreateListViewItem("item" & $x & "|col" & $x & "2|col" & $x & "3", $idListview)
	Next
	GUISetState(@SW_SHOW)

	$iIndex = Random(0, 29, 1)
	MsgBox($MB_SYSTEMMODAL, "Information", $iIndex & " is Visible: " & _GUICtrlListView_IsItemVisible($idListview, $iIndex))

	Do
		$iMsg = GUIGetMsg()
	Until $iMsg = $GUI_EVENT_CLOSE
EndFunc   ;==>Example
