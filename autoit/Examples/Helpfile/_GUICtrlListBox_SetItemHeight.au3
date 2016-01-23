#include <GUIConstantsEx.au3>
#include <GuiListBox.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idListBox

	; Create GUI
	GUICreate("List Box Set Item Height", 400, 296)
	$idListBox = GUICtrlCreateList("", 2, 2, 396, 296)
	GUISetState(@SW_SHOW)

	; Add strings
	_GUICtrlListBox_BeginUpdate($idListBox)
	For $iI = 1 To 9
		_GUICtrlListBox_AddString($idListBox, StringFormat("%03d : Random string", Random(1, 100, 1)))
	Next
	_GUICtrlListBox_EndUpdate($idListBox)

	; Show item height
	MsgBox($MB_SYSTEMMODAL, "Information", "Item height: " & _GUICtrlListBox_GetItemHeight($idListBox))

	; Set item height
	_GUICtrlListBox_SetItemHeight($idListBox, 26)

	; Show item height
	MsgBox($MB_SYSTEMMODAL, "Information", "Item height: " & _GUICtrlListBox_GetItemHeight($idListBox))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
