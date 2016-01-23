#include <GUIConstantsEx.au3>
#include <GuiTab.au3>
#include <GuiToolTip.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hTool, $idTab

	; Create GUI
	GUICreate("Tab Control Set Tool Tips", 400, 300)
	$idTab = GUICtrlCreateTab(2, 2, 396, 296)
	GUISetState(@SW_SHOW)

	; Add tabs
	_GUICtrlTab_InsertItem($idTab, 0, "Tab 1")
	_GUICtrlTab_InsertItem($idTab, 1, "Tab 2")
	_GUICtrlTab_InsertItem($idTab, 2, "Tab 3")

	; Get/Set tooltip
	$hTool = _GUIToolTip_Create(GUICtrlGetHandle($idTab))
	_GUICtrlTab_SetToolTips($idTab, $hTool)
	MsgBox($MB_SYSTEMMODAL, "Information", "ToolTip handle: 0x" & _GUICtrlTab_GetToolTips($idTab))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
