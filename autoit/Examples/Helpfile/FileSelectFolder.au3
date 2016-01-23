#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Create a constant variable in Local scope of the message to display in FileSelectFolder.
	Local Const $sMessage = "Select a folder"

	; Display an open dialog to select a file.
	Local $sFileSelectFolder = FileSelectFolder($sMessage, "")
	If @error Then
		; Display the error message.
		MsgBox($MB_SYSTEMMODAL, "", "No folder was selected.")
	Else
		; Display the selected folder.
		MsgBox($MB_SYSTEMMODAL, "", "You chose the following folder:" & @CRLF & $sFileSelectFolder)
	EndIf
EndFunc   ;==>Example
