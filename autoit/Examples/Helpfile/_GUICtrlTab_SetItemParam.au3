#include <GUIConstantsEx.au3>
#include <GuiTab.au3>
#include <MsgBoxConstants.au3>

; Warning do not use SetItemParam on items created with GUICtrlCreateTabItem
; Param is the controlID for items created with built-in functions

Example()

Func Example()
	Local $hGUI, $hTab

	; Create GUI
	$hGUI = GUICreate("(UDF Created) Tab Control Set Item Param", 400, 300)
	$hTab = _GUICtrlTab_Create($hGUI, 2, 2, 396, 296)
	GUISetState(@SW_SHOW)

	; Add tabs
	_GUICtrlTab_InsertItem($hTab, 0, "Tab 1")
	_GUICtrlTab_InsertItem($hTab, 1, "Tab 2")
	_GUICtrlTab_InsertItem($hTab, 2, "Tab 3")

	; Get/Set tab 1 parameter
	_GUICtrlTab_SetItemParam($hTab, 0, 1234)
	MsgBox($MB_SYSTEMMODAL, "Information", "Tab 1 parameter: " & _GUICtrlTab_GetItemParam($hTab, 0))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
