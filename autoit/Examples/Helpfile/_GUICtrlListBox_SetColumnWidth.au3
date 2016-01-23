#include <GUIConstantsEx.au3>
#include <GuiListBox.au3>

Example()

Func Example()
	Local $idListBox

	; Create GUI
	GUICreate("List Box Set Column Width", 400, 296)
	$idListBox = GUICtrlCreateList("", 2, 2, 396, 296, BitOR($LBS_STANDARD, $LBS_MULTICOLUMN))
	GUISetState(@SW_SHOW)

	; Set the width of the columns
	_GUICtrlListBox_SetColumnWidth($idListBox, 100)

	; Add strings
	_GUICtrlListBox_BeginUpdate($idListBox)
	For $iI = 1 To 50
		_GUICtrlListBox_AddString($idListBox, StringFormat("Item %03d", $iI))
	Next
	_GUICtrlListBox_EndUpdate($idListBox)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
