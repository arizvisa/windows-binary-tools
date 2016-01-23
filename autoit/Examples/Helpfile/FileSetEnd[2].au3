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

	; Write data to the file using the handle returned by FileOpen and set the end of the file.
	FileWrite($hFileOpen, "ABCDEF")
	FileSetEnd($hFileOpen)

	; Display the file size and contents.
	MsgBox($MB_SYSTEMMODAL, "", "Size: " & FileGetSize($sFilePath) & @CRLF & "Data: " & @CRLF & FileRead($sFilePath))

	; Expand the size of the file to 9 bytes and don't write any additional data.
	FileSetPos($hFileOpen, 9, $FILE_BEGIN)
	FileSetEnd($hFileOpen)

	; Display the file size and contents.
	MsgBox($MB_SYSTEMMODAL, "", "Size: " & FileGetSize($sFilePath) & @CRLF & "Data: " & @CRLF & FileRead($sFilePath))

	; Move the position after ABCDEF i.e. 6 bytes and then write additional data which will expand the file to 12 bytes.
	FileSetPos($hFileOpen, 6, $FILE_BEGIN)
	FileWrite($hFileOpen, "HIJKLM")
	FileSetEnd($hFileOpen) ; Set the end of the file.

	; Display the file size and contents.
	MsgBox($MB_SYSTEMMODAL, "", "Size: " & FileGetSize($sFilePath) & @CRLF & "Data: " & @CRLF & FileRead($sFilePath))

	; Truncate the file size to 9 bytes.
	FileSetPos($hFileOpen, 9, $FILE_BEGIN)
	FileSetEnd($hFileOpen) ; Set the end of the file.

	; Display the file size and contents.
	MsgBox($MB_SYSTEMMODAL, "", "Size: " & FileGetSize($sFilePath) & @CRLF & "Data: " & @CRLF & FileRead($sFilePath))

	; Close the handle returned by FileOpen.
	FileClose($hFileOpen)

	; Delete the temporary file.
	FileDelete($sFilePath)
EndFunc   ;==>Example
