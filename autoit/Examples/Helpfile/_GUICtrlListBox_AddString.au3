#include <GUIConstantsEx.au3>
#include <GuiListBox.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $idListBox

	; Create GUI
	GUICreate("List Box Add String", 400, 296)
	$idListBox = GUICtrlCreateList("", 2, 2, 396, 296, BitOR($WS_BORDER, $WS_VSCROLL, $LBS_NOTIFY, $LBS_DISABLENOSCROLL, $WS_HSCROLL))

	GUISetState(@SW_SHOW)

	; Add strings
	_GUICtrlListBox_BeginUpdate($idListBox)
	For $iI = 1 To 9
		_GUICtrlListBox_AddString($idListBox, StringFormat("%03d : Random string", Random(1, 100, 1)))
	Next
	_GUICtrlListBox_InsertString($idListBox, "Exact teXt", 3)
	_GUICtrlListBox_InsertString($idListBox, "This is the string that we're looking for", 6)
	_GUICtrlListBox_InsertString($idListBox, _
			"Let's add one really long line of text so that we can set the horizontal scroll bar and " & _
			"show that, unless we dynamically update the scroll bar, it won't show the full line.", 9)
	_GUICtrlListBox_UpdateHScroll($idListBox)
	_GUICtrlListBox_EndUpdate($idListBox)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
