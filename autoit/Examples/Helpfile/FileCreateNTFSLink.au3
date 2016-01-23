#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Example()

Func Example()
	; Create a constant variable in Local scope of the filepath that will be read/written to.
	Local Const $sFilePath = _WinAPI_GetTempFileName(@TempDir)

	; Create a temporary file to link to.
	If Not FileWrite($sFilePath, "This is an example of using FileCreateNTFSLink.") Then
		MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst writing the temporary file.")
		Return False
	EndIf

	; Create a NTFS link of the .txt file to the .log file on the desktop.
	Local $iNTFSLink = FileCreateNTFSLink($sFilePath, @DesktopDir & "\ExampleNTFSLink.log")

	; Display a message of whether the NTFS link was created.
	If $iNTFSLink Then
		; Open the desktop directory.
		ShellExecute(@DesktopDir)

		MsgBox($MB_SYSTEMMODAL, "", "The NTFS link was created." & @CRLF & "FileCreateNTFSLink returned: " & $iNTFSLink)
	Else
		MsgBox($MB_SYSTEMMODAL, "", "The NTFS link wasn't created." & @CRLF & "FileCreateNTFSLink returned: " & $iNTFSLink)
	EndIf

	; Delete the temporary files.
	FileDelete($sFilePath)
	FileDelete(@DesktopDir & "\ExampleNTFSLink.log")
EndFunc   ;==>Example
