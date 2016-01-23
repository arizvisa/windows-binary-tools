#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Example()

Func Example()
	; Create a constant variable in Local scope of the filepath that will be read/written to.
	Local Const $sFilePath = _WinAPI_GetTempFileName(@TempDir)

	; Create an INI section structure as a string.
	Local $sSection = "Title=AutoIt" & @LF & "Version=" & @AutoItVersion & @LF & "OS=" & @OSVersion

	; Write the string to the sections labelled 'General', 'Version' and 'Other'.
	IniWriteSection($sFilePath, "General", $sSection)
	IniWriteSection($sFilePath, "Version", $sSection)
	IniWriteSection($sFilePath, "Other", $sSection)

	; Rename the section labelled 'General' to 'System'.
	IniRenameSection($sFilePath, "General", "System")

	; Read the INI section names. This will return a 1 dimensional array.
	Local $aArray = IniReadSectionNames($sFilePath)

	; Check if an error occurred.
	If Not @error Then
		; Enumerate through the array displaying the section names.
		For $i = 1 To $aArray[0]
			MsgBox($MB_SYSTEMMODAL, "", "Section: " & $aArray[$i])
		Next
	EndIf

	; Delete the INI file.
	FileDelete($sFilePath)
EndFunc   ;==>Example
