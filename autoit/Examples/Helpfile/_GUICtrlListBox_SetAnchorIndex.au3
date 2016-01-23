#include <GUIConstantsEx.au3>
#include <GuiListBox.au3>

Example()

Func Example()
	Local $iIndex, $idListBox

	; Create GUI
	GUICreate("List Box Set Anchor Index", 400, 296)
	$idListBox = GUICtrlCreateList("", 2, 2, 396, 296)
	GUISetState(@SW_SHOW)

	; Add strings
	_GUICtrlListBox_BeginUpdate($idListBox)
	For $iI = 1 To 9
		_GUICtrlListBox_AddString($idListBox, StringFormat("%03d : Random string", Random(1, 100, 1)))
	Next
	_GUICtrlListBox_EndUpdate($idListBox)

	; Set anchor index
	_GUICtrlListBox_SetAnchorIndex($idListBox, 2)

	; Read anchor index
	$iIndex = _GUICtrlListBox_GetAnchorIndex($idListBox)
	_GUICtrlListBox_SetCurSel($idListBox, $iIndex)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
