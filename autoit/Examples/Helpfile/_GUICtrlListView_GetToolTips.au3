#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGui, $hToolTip, $hListView

	$hGui = GUICreate("ListView Get ToolTips", 400, 300)
	$hListView = _GUICtrlListView_Create($hGui, "", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	; Add columns
	_GUICtrlListView_AddColumn($hListView, "Items", 100)

	; Add items
	_GUICtrlListView_AddItem($hListView, "Item 1")
	_GUICtrlListView_AddItem($hListView, "Item 2")
	_GUICtrlListView_AddItem($hListView, "Item 3")

	; Show tooltip handle
	$hToolTip = _GUICtrlListView_GetToolTips($hListView)
	MsgBox($MB_SYSTEMMODAL, "Information", "ToolTip Handle: 0x" & Hex($hToolTip) & @CRLF & _
			"IsPtr = " & IsPtr($hToolTip) & " IsHWnd = " & IsHWnd($hToolTip))

	_GUICtrlListView_SetToolTips($hListView, $hToolTip)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
