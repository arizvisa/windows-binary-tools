#include <GUIConstantsEx.au3>
#include <GuiListBox.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $sItems, $aItems, $idListBox

	; Create GUI
	GUICreate("List Box Get Sel Items Text", 400, 296)
	$idListBox = GUICtrlCreateList("", 2, 2, 396, 296, BitOR($LBS_STANDARD, $LBS_EXTENDEDSEL))
	GUISetState(@SW_SHOW)

	; Add strings
	_GUICtrlListBox_BeginUpdate($idListBox)
	For $iI = 1 To 9
		_GUICtrlListBox_AddString($idListBox, StringFormat("%03d : Random string", Random(1, 100, 1)))
	Next
	_GUICtrlListBox_EndUpdate($idListBox)

	; Select a few items
	_GUICtrlListBox_SetSel($idListBox, 3)
	_GUICtrlListBox_SetSel($idListBox, 4)
	_GUICtrlListBox_SetSel($idListBox, 5)

	; Get text of selected items
	$aItems = _GUICtrlListBox_GetSelItemsText($idListBox)
	For $iI = 1 To $aItems[0]
		$sItems &= @CRLF & $aItems[$iI]
	Next
	MsgBox($MB_SYSTEMMODAL, "Information", "Items Selected: " & $sItems)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
