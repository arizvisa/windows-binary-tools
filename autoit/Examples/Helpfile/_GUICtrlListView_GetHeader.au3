#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idListview

	GUICreate("ListView Get Header", 400, 300)
	$idListview = GUICtrlCreateListView("col1|col2|col3", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	MsgBox($MB_SYSTEMMODAL, "Information", "ListView Header Handle: 0x" & Hex(_GUICtrlListView_GetHeader($idListview)) & @CRLF & _
			"IsPtr = " & IsPtr(_GUICtrlListView_GetHeader($idListview)) & " IsHWnd = " & IsHWnd(_GUICtrlListView_GetHeader($idListview)))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	GUIDelete()
EndFunc   ;==>Example
