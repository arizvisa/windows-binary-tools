#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $iY, $idListview

	GUICreate("ListView Approximate View Height", 400, 300)
	$idListview = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	; Add column
	_GUICtrlListView_InsertColumn($idListview, 0, "Column 1", 100)

	; Add items
	For $iI = 0 To 9
		_GUICtrlListView_AddItem($idListview, "Row " & $iI)
	Next

	MsgBox($MB_SYSTEMMODAL, "Information", "Approximate View Height")
	; Resize view height
	$iY = _GUICtrlListView_ApproximateViewHeight($idListview)
	_WinAPI_SetWindowPos(GUICtrlGetHandle($idListview), 0, 2, 2, 394, $iY, $SWP_NOZORDER)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
