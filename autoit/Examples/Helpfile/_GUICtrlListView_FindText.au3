#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $iI, $idListview

	; Create GUI
	GUICreate("ListView Find Text", 400, 300)
	$idListview = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	; Add columns
	_GUICtrlListView_AddColumn($idListview, "Items", 100)

	; Add items
	_GUICtrlListView_BeginUpdate($idListview)
	For $iI = 1 To 49
		_GUICtrlListView_AddItem($idListview, "Item " & $iI)
	Next
	_GUICtrlListView_AddItem($idListview, "Target item")
	For $iI = 51 To 100
		_GUICtrlListView_AddItem($idListview, "Item " & $iI)
	Next
	_GUICtrlListView_EndUpdate($idListview)

	; Search for target item
	$iI = _GUICtrlListView_FindText($idListview, "tArGeT")
	MsgBox($MB_SYSTEMMODAL, "Information", "Target Item Index: " & $iI)
	_GUICtrlListView_EnsureVisible($idListview, $iI)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
