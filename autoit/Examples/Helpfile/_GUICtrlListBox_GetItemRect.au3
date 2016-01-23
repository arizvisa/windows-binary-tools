#include <GUIConstantsEx.au3>
#include <GuiListBox.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $aRect, $idListBox

	; Create GUI
	GUICreate("List Box Get Item Rect", 400, 296)
	$idListBox = GUICtrlCreateList("", 2, 2, 396, 296)
	GUISetState(@SW_SHOW)

	; Add strings
	_GUICtrlListBox_BeginUpdate($idListBox)
	For $iI = 1 To 9
		_GUICtrlListBox_AddString($idListBox, StringFormat("%03d : Random string", Random(1, 100, 1)))
	Next
	_GUICtrlListBox_EndUpdate($idListBox)

	; Show item rectangle
	$aRect = _GUICtrlListBox_GetItemRect($idListBox, 4)
	MsgBox($MB_SYSTEMMODAL, "Information", "Item 5 Rectangle: " & $aRect[0] & ", " & $aRect[1] & ", " & $aRect[2] & ", " & $aRect[3])

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
