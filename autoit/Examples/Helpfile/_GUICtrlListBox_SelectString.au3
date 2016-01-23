#include <GUIConstantsEx.au3>
#include <GuiListBox.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $sText, $idListBox

	; Create GUI
	GUICreate("List Box Select String", 400, 296)
	$idListBox = GUICtrlCreateList("", 2, 2, 396, 296)
	GUISetState(@SW_SHOW)

	; Add strings
	_GUICtrlListBox_BeginUpdate($idListBox)
	For $iI = 1 To 10
		$sText = StringFormat("%03d : Random string ", Random(1, 100, 1))
		For $iX = 1 To Random(1, 20, 1)
			$sText &= Chr(Random(65, 90, 1))
		Next
		_GUICtrlListBox_AddString($idListBox, $sText)
	Next
	_GUICtrlListBox_AddString($idListBox, "020 : Target string")
	_GUICtrlListBox_EndUpdate($idListBox)

	; Select string
	MsgBox($MB_SYSTEMMODAL, "Information", "Target String Index: " & _GUICtrlListBox_SelectString($idListBox, "020 : T"));

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
