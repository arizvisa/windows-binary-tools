#include <GUIConstantsEx.au3>
#include <GuiTab.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idTab

	; Create GUI
	GUICreate("Tab Control Set Item State", 400, 300)
	$idTab = GUICtrlCreateTab(2, 2, 396, 296, $TCS_BUTTONS)
	GUISetState(@SW_SHOW)

	; Add tabs
	_GUICtrlTab_InsertItem($idTab, 0, "Tab 1")
	_GUICtrlTab_InsertItem($idTab, 1, "Tab 2")
	_GUICtrlTab_InsertItem($idTab, 2, "Tab 3")

	; Get/Set tab 2 state
	_GUICtrlTab_SetItemState($idTab, 1, $TCIS_BUTTONPRESSED)
	MsgBox($MB_SYSTEMMODAL, "Information", "Tab 2 state: " & _ExplainItemState(_GUICtrlTab_GetItemState($idTab, 1)))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

Func _ExplainItemState($iState)
	Local $sText = ""
	If $iState = 0 Then $sText &= "No state set on this item" & @CRLF
	If BitAND($iState, 1) Then $sText &= "Button Pressed" & @CRLF
	If BitAND($iState, 2) Then $sText &= "Button Highlighted"
	Return $sText
EndFunc   ;==>_ExplainItemState
