#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Example()

Func Example()
	; Create a constant variable in Local scope of the filepath that will be read/written to.
	Local Const $sFilePath = _WinAPI_GetTempFileName(@TempDir)

	; Set the modified timestamp of the file to 1st Nov 2003 and use the current time.
	Local $iFileSetTime = FileSetTime($sFilePath, "20031101", $FT_MODIFIED)

	; Display the modified timestamp of the file and return as a string in the format YYYYMMDDHHMMSS.
	If $iFileSetTime Then
		MsgBox($MB_SYSTEMMODAL, "", "Timestamp:" & @CRLF & FileGetTime($sFilePath, $FT_MODIFIED, 1))
	Else
		MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst setting the timestamp of the file.")
	EndIf

	; Delete the temporary file.
	FileDelete($sFilePath)
EndFunc   ;==>Example
