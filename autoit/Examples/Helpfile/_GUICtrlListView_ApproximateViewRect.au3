#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $aXY, $idListview

	GUICreate("ListView Approximate View Rect", 400, 300)
	$idListview = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	; Add column
	_GUICtrlListView_InsertColumn($idListview, 0, "Column 1", 100)

	; Add items
	For $iI = 0 To 9
		_GUICtrlListView_AddItem($idListview, "Row " & $iI)
	Next

	MsgBox($MB_SYSTEMMODAL, "Information", "Approximate View Rect")
	; Resize view
	$aXY = _GUICtrlListView_ApproximateViewRect($idListview)
	_WinAPI_SetWindowPos(GUICtrlGetHandle($idListview), 0, 2, 2, $aXY[0], $aXY[1], $SWP_NOZORDER)
	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
