#include <GUIConstantsEx.au3>
#include <GuiListBox.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $idListBox

	; Create GUI
	GUICreate("List Box Get Horizontal Extent", 400, 296)
	$idListBox = GUICtrlCreateList("", 2, 2, 396, 296, BitOR($WS_BORDER, $WS_VSCROLL, $LBS_NOTIFY, $LBS_DISABLENOSCROLL, $WS_HSCROLL))
	GUISetState(@SW_SHOW)

	; Add long string
	_GUICtrlListBox_AddString($idListBox, "AutoIt v3 is a freeware BASIC-like scripting language designed for automating the Windows GUI.")

	; Show current horizontal extent
	MsgBox($MB_SYSTEMMODAL, "Information", "Horizontal Extent: " & _GUICtrlListBox_GetHorizontalExtent($idListBox))

	_GUICtrlListBox_SetHorizontalExtent($idListBox, 500)

	; Show current horizontal extent
	MsgBox($MB_SYSTEMMODAL, "Information", "Horizontal Extent: " & _GUICtrlListBox_GetHorizontalExtent($idListBox))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
