#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $aItem, $sText, $idListview

	GUICreate("ListView Get Item Text Array", 400, 300)

	$idListview = GUICtrlCreateListView("col1|col2|col3", 2, 2, 394, 268)
	GUICtrlCreateListViewItem("line1|data1|more1", $idListview)
	GUICtrlCreateListViewItem("line2|data2|more2", $idListview)
	GUICtrlCreateListViewItem("line3|data3|more3", $idListview)
	GUICtrlCreateListViewItem("line4|data4|more4", $idListview)
	GUICtrlCreateListViewItem("line5|data5|more5", $idListview)

	GUISetState(@SW_SHOW)

	; Get item 2 text
	$aItem = _GUICtrlListView_GetItemTextArray($idListview, 1)
	For $i = 1 To $aItem[0]
		$sText &= StringFormat("Column[%2d] %s", $i, $aItem[$i]) & @CRLF
	Next

	MsgBox($MB_SYSTEMMODAL, "Information", "Item 2 (All Columns) Text: " & @CRLF & @CRLF & $sText)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
