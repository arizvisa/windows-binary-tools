#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Example()

Func Example()
	; Create a constant variable in Local scope of the filepath that will be read/written to.
	Local Const $sFilePath = _WinAPI_GetTempFileName(@TempDir)

	; Create a temporary file to read data from.
	If Not FileWrite($sFilePath, "This is an example of using FileRecycle.") Then
		MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst writing the temporary file.")
		Return False
	EndIf

	; Display the contents of the file passing the filepath to FileRead instead of a handle returned by FileOpen.
	MsgBox($MB_SYSTEMMODAL, "", "Contents of the file:" & @CRLF & FileRead($sFilePath))

	; Delete the temporary file by sending to the recycle bin.
	Local $iRecycle = FileRecycle($sFilePath)

	; Display a message of whether the file was deleted and open the recycle bin if successful.
	If $iRecycle Then
		MsgBox($MB_SYSTEMMODAL, "", "The file was successfuly deleted.")

		; Open the recycle bin by using the following CLSID.
		ShellExecute("::{645FF040-5081-101B-9F08-00AA002F954E}")
	Else
		MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst deleting the file.")
	EndIf
EndFunc   ;==>Example
