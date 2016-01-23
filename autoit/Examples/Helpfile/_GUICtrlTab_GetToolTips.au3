#include <GUIConstantsEx.au3>
#include <GuiTab.au3>
#include <GuiToolTip.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI, $hTool, $hTab

	; Create GUI
	$hGUI = GUICreate("Tab Control Get Tool Tips", 400, 300)
	$hTab = _GUICtrlTab_Create($hGUI, 2, 2, 396, 296)
	GUISetState(@SW_SHOW)

	; Add tabs
	_GUICtrlTab_InsertItem($hTab, 0, "Tab 1")
	_GUICtrlTab_InsertItem($hTab, 1, "Tab 2")
	_GUICtrlTab_InsertItem($hTab, 2, "Tab 3")

	; Get/Set tooltip
	$hTool = _GUIToolTip_Create($hTab)
	_GUICtrlTab_SetToolTips($hTab, $hTool)

	MsgBox($MB_SYSTEMMODAL, "Information", "ToolTip handle: 0x" & _GUICtrlTab_GetToolTips($hTab) & @CRLF & _
			"IsPtr = " & IsPtr(_GUICtrlTab_GetToolTips($hTab)) & " IsHWnd = " & IsHWnd(_GUICtrlTab_GetToolTips($hTab)))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
