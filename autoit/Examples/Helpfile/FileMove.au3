#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Example()

Func Example()
	; Create a constant variable in Local scope of the filepath that will be read/written to.
	Local Const $sFilePath = _WinAPI_GetTempFileName(@TempDir)

	; Create a temporary file to move.
	If Not FileWrite($sFilePath, "This is an example of using FileMove.") Then
		MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst writing the temporary file.")
		Return False
	EndIf

	; Move Au3 files in the temporary directory to a new folder/directory called Au3Files.
	FileMove(@TempDir & "\*.au3", @TempDir & "\Au3Files\", $FC_OVERWRITE + $FC_CREATEPATH)

	; Display the temporary directory.
	ShellExecute(@TempDir)
EndFunc   ;==>Example
