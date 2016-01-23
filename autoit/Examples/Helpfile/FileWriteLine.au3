#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Example()

Func Example()
	; Create a constant variable in Local scope of the filepath that will be read/written to.
	Local Const $sFilePath = _WinAPI_GetTempFileName(@TempDir)

	; Create a temporary file to write data to.
	If Not FileWrite($sFilePath, "Start of the FileWriteLine example, line 1. " & @CRLF) Then
		MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst writing the temporary file.")
		Return False
	EndIf

	; Open the file for writing (append to the end of a file) and store the handle to a variable.
	Local $hFileOpen = FileOpen($sFilePath, $FO_APPEND)
	If $hFileOpen = -1 Then
		MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst writing the temporary file.")
		Return False
	EndIf

	; Write data to the file using the handle returned by FileOpen.
	FileWriteLine($hFileOpen, "Line 2")
	FileWriteLine($hFileOpen, "This is line 3 as a new line was appended to the last FileWriteLine call." & @CRLF)
	FileWriteLine($hFileOpen, "Line 4" & @CRLF)
	FileWriteLine($hFileOpen, "Line 5")

	; Close the handle returned by FileOpen.
	FileClose($hFileOpen)

	; Display the contents of the file passing the filepath to FileRead instead of a handle returned by FileOpen.
	MsgBox($MB_SYSTEMMODAL, "", "Contents of the file:" & @CRLF & FileRead($sFilePath))

	; Delete the temporary file.
	FileDelete($sFilePath)
EndFunc   ;==>Example
