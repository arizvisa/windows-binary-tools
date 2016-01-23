#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hToolTip, $idListView

	GUICreate("ListView Set ToolTips", 400, 300)
	$idListView = GUICtrlCreateListView("", 2, 2, 394, 268)
	; $idListView = _GUICtrlListView_Create($hGui, "", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	; Add columns
	_GUICtrlListView_AddColumn($idListView, "Items", 100)

	; Add items
	_GUICtrlListView_AddItem($idListView, "Item 1")
	_GUICtrlListView_AddItem($idListView, "Item 2")
	_GUICtrlListView_AddItem($idListView, "Item 3")

	; Show tooltip handle
	$hToolTip = _GUICtrlListView_GetToolTips($idListView)
	MsgBox($MB_SYSTEMMODAL, "Information", "ToolTip Handle: 0x" & Hex($hToolTip))
	Local $hPrevTooltips = _GUICtrlListView_SetToolTips($idListView, $hToolTip)
	MsgBox($MB_SYSTEMMODAL, "Information", "Previous ToolTip Handle: 0x" & Hex($hPrevTooltips) & @CRLF & _
			"IsPtr = " & IsPtr($hPrevTooltips) & " IsHWnd = " & IsHWnd($hPrevTooltips))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
