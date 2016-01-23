#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Example()

Func Example()
	; Create a constant variable in Local scope of the filepath that will be read/written to.
	Local Const $sFilePath = _WinAPI_GetTempFileName(@TempDir)

	; Open the file for writing (overwrite the file) and store the handle to a variable.
	Local $hFileOpen = FileOpen($sFilePath, $FO_OVERWRITE)
	If $hFileOpen = -1 Then
		MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst writing the temporary file.")
		Return False
	EndIf

	; Write data to the file using the handle returned by FileOpen.
	FileWriteLine($hFileOpen, "Line 1")
	FileWriteLine($hFileOpen, "Line 2")
	FileWriteLine($hFileOpen, "Line 3")

	; Flush the file to disk.
	FileFlush($hFileOpen)

	; Now, adjust the position to the beginning.
	FileSetPos($hFileOpen, 0, $FILE_BEGIN)

	; Check file position and try to read contents for current position.
	MsgBox($MB_SYSTEMMODAL, "", "Position: " & FileGetPos($hFileOpen) & @CRLF & "Data: " & @CRLF & FileRead($hFileOpen))

	; Write data to the file using the handle returned by FileOpen.
	FileWriteLine($hFileOpen, "Line 4")
	FileWriteLine($hFileOpen, "Line 5")
	FileWriteLine($hFileOpen, "Line 6")

	; Now, adjust the position to the beginning.
	FileSetPos($hFileOpen, 0, $FILE_BEGIN)

	; Check file position and try to read contents for current position.
	MsgBox($MB_SYSTEMMODAL, "", "Position: " & FileGetPos($hFileOpen) & @CRLF & "Data: " & @CRLF & FileRead($hFileOpen))

	; Now, adjust the position to the beginning.
	FileSetPos($hFileOpen, 0, $FILE_BEGIN)

	; Set the end of the file at the current position.
	FileSetEnd($hFileOpen)

	; Check file position and try to read contents for current position. The contents have been destroyed.
	MsgBox($MB_SYSTEMMODAL, "", "Position: " & FileGetPos($hFileOpen) & @CRLF & "Data: " & @CRLF & FileRead($hFileOpen))

	; Close the handle returned by FileOpen.
	FileClose($hFileOpen)

	; Delete the temporary file.
	FileDelete($sFilePath)
EndFunc   ;==>Example
