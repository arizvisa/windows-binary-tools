#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	GUICreate("My GUICtrlRead") ; will create a dialog box that when displayed is centered

	Local $idMenu1 = GUICtrlCreateMenu("File")

	Local $idList = GUICtrlCreateList("", 10, 10, -1, 100)
	GUICtrlSetData(-1, "item1|item2|item3", "item2")

	Local $idButton = GUICtrlCreateButton("Read", 10, 110, 50)
	GUICtrlSetState(-1, $GUI_FOCUS) ; the focus is on this button

	GUISetState(@SW_SHOW) ; will display an empty dialog box

	Local $idMsg, $iMenustate, $sMenutext
	; Loop until the user exits.
	Do
		$idMsg = GUIGetMsg()
		If $idMsg = $idButton Then
			MsgBox($MB_SYSTEMMODAL, "Selected listbox entry", GUICtrlRead($idList)) ; display the selected listbox entry
			$iMenustate = GUICtrlRead($idMenu1) ; return the state of the menu item
			$sMenutext = GUICtrlRead($idMenu1, $GUI_READ_EXTENDED) ; return the text of the menu item
			MsgBox($MB_SYSTEMMODAL, "State and text of the menuitem", "state:" & $iMenustate & @CRLF & "text:" & $sMenutext)
		EndIf
	Until $idMsg = $GUI_EVENT_CLOSE
EndFunc   ;==>Example
