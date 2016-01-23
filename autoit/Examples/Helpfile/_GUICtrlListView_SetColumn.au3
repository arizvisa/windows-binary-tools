#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $aInfo, $idListview

	GUICreate("ListView Set Column", 400, 300)
	$idListview = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	; Add columns
	_GUICtrlListView_AddColumn($idListview, "Column 1", 100)
	_GUICtrlListView_AddColumn($idListview, "Column 2", 100)
	_GUICtrlListView_AddColumn($idListview, "Column 3", 100)

	; Change column
	$aInfo = _GUICtrlListView_GetColumn($idListview, 0)
	MsgBox($MB_SYSTEMMODAL, "Information", "Column 1 Width: " & $aInfo[4])
	_GUICtrlListView_SetColumn($idListview, 0, "New Column 1", 150, 1)
	$aInfo = _GUICtrlListView_GetColumn($idListview, 0)
	MsgBox($MB_SYSTEMMODAL, "Information", "Column 1 Width: " & $aInfo[4])

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
