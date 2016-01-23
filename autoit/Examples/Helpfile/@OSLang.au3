#include <MsgBoxConstants.au3>

MsgBox($MB_SYSTEMMODAL, "", "The language of the OS is: " & _GetLanguage() & " (" & LCIDToLocaleName("0x" & @OSLang) & ")")

; Retrieve the language of the operating system.
Func _GetLanguage()
	; @OSLang is four characters in length, the first two is the dialect and the remaining two are the language group.
	; Therefore we only require the language group and therefore select the two right-most characters.
	Switch StringRight(@OSLang, 2)
		Case "07"
			Return "German"
		Case "09"
			Return "English"
		Case "0a"
			Return "Spanish"
		Case "0b"
			Return "Finnish"
		Case "0c"
			Return "French"
		Case "10"
			Return "Italian"
		Case "13"
			Return "Dutch"
		Case "14"
			Return "Norwegian"
		Case "15"
			Return "Polish"
		Case "16"
			Return "Portuguese"
		Case "1d"
			Return "Swedish"

		Case Else
			Return "Other (can't determine with @OSLang directly)"

	EndSwitch
EndFunc   ;==>_GetLanguage

Func LCIDToLocaleName($iLCID)
	Local $aRet = DllCall("kernel32.dll", "int", "LCIDToLocaleName", "int", $iLCID, "wstr", "", "int", 85, "dword", 0)
	Return $aRet[2]
EndFunc   ;==>LCIDToLocaleName
