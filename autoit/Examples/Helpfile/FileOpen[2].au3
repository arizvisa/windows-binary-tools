#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Example()

Func Example()
	; Create a constant variable in Local scope of the filepath that will be read/written to.
	Local Const $sFilePath = _WinAPI_GetTempFileName(@TempDir)

	; Open the file for read/write access.
	Local $hFileOpen = FileOpen($sFilePath, $FO_READ + $FO_OVERWRITE)
	If $hFileOpen = -1 Then
		MsgBox($MB_SYSTEMMODAL, "", "An error occurred when reading/writing the file.")
		Return False
	EndIf

	; Write some data.
	FileWrite($hFileOpen, "This is some data to show that the handle was open with read/write access." & @CRLF)

	; Retrieve the current position in the file.
	Local $iFilePos = FileGetPos($hFileOpen)

	; Now, adjust the position to the beginning.
	FileSetPos($hFileOpen, 0, $FILE_BEGIN)

	; Display the contents of the file.
	MsgBox($MB_SYSTEMMODAL, "", FileRead($hFileOpen))

	; Now, adjust the position back to the previous position.
	FileSetPos($hFileOpen, 0, $iFilePos)

	; Write some addition data.
	FileWrite($hFileOpen, "This is some additional data.")

	; Adjust the position back to the previous position.
	FileSetPos($hFileOpen, 0, $FILE_BEGIN)

	; Display the contents of the file.
	MsgBox($MB_SYSTEMMODAL, "", FileRead($hFileOpen))

	; Close the handle returned by FileOpen.
	FileClose($hFileOpen)

	; Delete the temporary file.
	FileDelete($sFilePath)

	Return True
EndFunc   ;==>Example
