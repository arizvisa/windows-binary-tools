#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Example()

Func Example()
	; Create a constant variable in Local scope of the filepath that will be read/written to.
	Local Const $sFilePath = _WinAPI_GetTempFileName(@TempDir)

	Local $iFileExists = FileExists($sFilePath)

	; Display a message of whether the file exists or not.
	If $iFileExists Then
		MsgBox($MB_SYSTEMMODAL, "", "The file exists." & @CRLF & "FileExist returned: " & $iFileExists)
	Else
		MsgBox($MB_SYSTEMMODAL, "", "The file doesn't exist." & @CRLF & "FileExist returned: " & $iFileExists)
	EndIf

	; Delete the temporary file.
	FileDelete($sFilePath)
EndFunc   ;==>Example
