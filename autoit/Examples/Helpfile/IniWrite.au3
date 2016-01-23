#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Example()

Func Example()
	; Create a constant variable in Local scope of the filepath that will be read/written to.
	Local Const $sFilePath = _WinAPI_GetTempFileName(@TempDir)

	; Write the value of 'AutoIt' to the key 'Title' and in the section labelled 'General'.
	IniWrite($sFilePath, "General", "Title", "AutoIt")

	; Read the INI file for the value of 'Title' in the section labelled 'General'.
	Local $sRead = IniRead($sFilePath, "General", "Title", "Default Value")

	; Display the value returned by IniRead.
	MsgBox($MB_SYSTEMMODAL, "", "The value of 'Title' in the section labelled 'General' is: " & $sRead)

	; Delete the key labelled 'Title'.
	IniDelete($sFilePath, "General", "Title")

	; Read the INI file for the value of 'Title' in the section labelled 'General'.
	$sRead = IniRead($sFilePath, "General", "Title", "Default Value")

	; Display the value returned by IniRead. Since there is no key stored the value will be the 'Default Value' passed to IniRead.
	MsgBox($MB_SYSTEMMODAL, "", "The value of 'Title' in the section labelled 'General' is: " & $sRead)

	; Delete the INI file.
	FileDelete($sFilePath)
EndFunc   ;==>Example
