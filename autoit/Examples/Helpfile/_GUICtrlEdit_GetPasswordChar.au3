#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idEdit

	; Create GUI
	GUICreate("Edit Get Password Char", 400, 300)
	$idEdit = GUICtrlCreateInput("Test of build-in control", 2, 2, 394, 25, $ES_PASSWORD)
	GUISetState(@SW_SHOW)

	MsgBox($MB_SYSTEMMODAL, "Information", "Password Char: " & _GUICtrlEdit_GetPasswordChar($idEdit))

	_GUICtrlEdit_SetPasswordChar($idEdit, "$") ; change password char to $

	MsgBox($MB_SYSTEMMODAL, "Information", "Password Char: " & _GUICtrlEdit_GetPasswordChar($idEdit))

	_GUICtrlEdit_SetPasswordChar($idEdit) ; display characters typed by the user.

	MsgBox($MB_SYSTEMMODAL, "Information", "Password Char: " & _GUICtrlEdit_GetPasswordChar($idEdit))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
