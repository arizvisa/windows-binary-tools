#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idCombo

	; Create GUI
	GUICreate("ComboBox Get Locale Sub-Language id", 400, 296)
	$idCombo = GUICtrlCreateCombo("", 2, 2, 396, 296)
	GUISetState(@SW_SHOW)

	; Add files
	_GUICtrlComboBox_BeginUpdate($idCombo)
	_GUICtrlComboBox_AddDir($idCombo, @WindowsDir & "\*.exe")
	_GUICtrlComboBox_EndUpdate($idCombo)

	; Show locale, country code, language identifier, primary language id, sub-language id
	MsgBox($MB_SYSTEMMODAL, "Information", _
			"Locale .................: " & _GUICtrlComboBox_GetLocale($idCombo) & @CRLF & _
			"Country code ........: " & _GUICtrlComboBox_GetLocaleCountry($idCombo) & @CRLF & _
			"Language identifier..: " & _GUICtrlComboBox_GetLocaleLang($idCombo) & @CRLF & _
			"Primary Language id : " & _GUICtrlComboBox_GetLocalePrimLang($idCombo) & @CRLF & _
			"Sub-Language id ....: " & _GUICtrlComboBox_GetLocaleSubLang($idCombo))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
