#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Example()

Func Example()
	; Create a constant variable in Local scope of the filepaths that will be renamed.
	Local Const $sSource = _WinAPI_GetTempFileName(@TempDir), _
			$sDestination = _WinAPI_GetTempFileName(@TempDir)

	; Create a temporary file to rename.
	If Not FileWrite($sSource, "This is an example of using FileMove.") Then
		MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst writing the temporary file.")
		Return False
	EndIf

	; Rename a file using FileMove and overwrite the new file if it exists.
	FileMove($sSource, $sDestination, $FC_OVERWRITE)

	; Display results that the destination file was renamed.
	MsgBox($MB_SYSTEMMODAL, "", "Does the source file exist?: " & FileExists($sSource) & @CRLF & _ ; FileExists should return 0.
			"Does destination file exist?: " & FileExists($sDestination) & @CRLF) ; FileExists should return 1.

	; Delete the temporary files. FileDelete checks if the file exists.
	FileDelete($sSource)
	FileDelete($sDestination)
EndFunc   ;==>Example
