#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Example()

Func Example()
	; Create a constant variable in Local scope of the filepath that will be read/written to.
	Local Const $sFilePath = _WinAPI_GetTempFileName(@TempDir)

	; Create an INI section structure as an array. The zeroth element is how many items are in the array, in this case 3.
	Local $aSection[4][2] = [[3, ""], ["Title", "AutoIt"], ["Version", @AutoItVersion], ["OS", @OSVersion]]

	; Write the array to the section labelled 'General'.
	IniWriteSection($sFilePath, "General", $aSection)

	; Read the INI section labelled 'General'. This will return a 2 dimensional array.
	Local $aArray = IniReadSection($sFilePath, "General")

	; Check if an error occurred.
	If Not @error Then
		; Enumerate through the array displaying the keys and their respective values.
		For $i = 1 To $aArray[0][0]
			MsgBox($MB_SYSTEMMODAL, "", "Key: " & $aArray[$i][0] & @CRLF & "Value: " & $aArray[$i][1])
		Next
	EndIf

	; Delete the INI file.
	FileDelete($sFilePath)
EndFunc   ;==>Example
