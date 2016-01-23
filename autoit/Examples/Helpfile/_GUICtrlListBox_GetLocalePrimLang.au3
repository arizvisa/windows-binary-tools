#include <GUIConstantsEx.au3>
#include <GuiListBox.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idListBox

	; Create GUI
	GUICreate("List Box Get Locale Primary Language id", 400, 296)
	$idListBox = GUICtrlCreateList("", 2, 2, 396, 296)
	GUISetState(@SW_SHOW)

	; Show locale, country code, language identifier, primary language id, sub-language id
	MsgBox($MB_SYSTEMMODAL, "Information", _
			"Locale .................: " & _GUICtrlListBox_GetLocale($idListBox) & @CRLF & _
			"Country code ........: " & _GUICtrlListBox_GetLocaleCountry($idListBox) & @CRLF & _
			"Language identifier..: " & _GUICtrlListBox_GetLocaleLang($idListBox) & @CRLF & _
			"Primary Language id : " & _GUICtrlListBox_GetLocalePrimLang($idListBox) & @CRLF & _
			"Sub-Language id ....: " & _GUICtrlListBox_GetLocaleSubLang($idListBox))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
