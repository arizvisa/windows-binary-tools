#include <GuiComboBoxEx.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI, $hCombo

	; Create GUI
	$hGUI = GUICreate("ComboBoxEx Get Locale Country Primary Language id", 400, 300)
	$hCombo = _GUICtrlComboBoxEx_Create($hGUI, "", 2, 2, 394, 100)
	GUISetState(@SW_SHOW)

	; Add files
	_GUICtrlComboBoxEx_AddDir($hCombo, "", $DDL_DRIVES, False)

	; Show locale, country code, language identifier, primary language id, sub-language id
	MsgBox($MB_SYSTEMMODAL, "Information", _
			"Locale .................: " & _GUICtrlComboBoxEx_GetLocale($hCombo) & @CRLF & _
			"Country code ........: " & _GUICtrlComboBoxEx_GetLocaleCountry($hCombo) & @CRLF & _
			"Language identifier..: " & _GUICtrlComboBoxEx_GetLocaleLang($hCombo) & @CRLF & _
			"Primary Language id : " & _GUICtrlComboBoxEx_GetLocalePrimLang($hCombo) & @CRLF & _
			"Sub-Language id ....: " & _GUICtrlComboBoxEx_GetLocaleSubLang($hCombo))

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example
