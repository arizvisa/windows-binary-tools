#include <GUIConstantsEx.au3>
#include <GuiTab.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idTab

	; Create GUI
	GUICreate("Tab Control Get Extended Style", 400, 300)
	$idTab = GUICtrlCreateTab(2, 2, 396, 296, BitOR($TCS_BUTTONS, $TCS_FLATBUTTONS))
	GUISetState(@SW_SHOW)

	; Add tabs
	_GUICtrlTab_InsertItem($idTab, 0, "Tab 1")
	_GUICtrlTab_InsertItem($idTab, 1, "Tab 2")
	_GUICtrlTab_InsertItem($idTab, 2, "Tab 3")

	; Get/Set extended styles
	_GUICtrlTab_SetExtendedStyle($idTab, $TCS_EX_FLATSEPARATORS)
	MsgBox($MB_SYSTEMMODAL, "Information", "Extended styles: 0x" & Hex(_GUICtrlTab_GetExtendedStyle($idTab)))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
