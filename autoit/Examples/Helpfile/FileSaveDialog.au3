#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>

Example()

Func Example()
	; Create a constant variable in Local scope of the message to display in FileSaveDialog.
	Local Const $sMessage = "Choose a filename."

	; Display a save dialog to select a file.
	Local $sFileSaveDialog = FileSaveDialog($sMessage, "::{450D8FBA-AD25-11D0-98A8-0800361B1103}", "Scripts (*.au3)", $FD_PATHMUSTEXIST)
	If @error Then
		; Display the error message.
		MsgBox($MB_SYSTEMMODAL, "", "No file was saved.")
	Else
		; Retrieve the filename from the filepath e.g. Example.au3.
		Local $sFileName = StringTrimLeft($sFileSaveDialog, StringInStr($sFileSaveDialog, "\", $STR_NOCASESENSE, -1))

		; Check if the extension .au3 is appended to the end of the filename.
		Local $iExtension = StringInStr($sFileName, ".", $STR_NOCASESENSE)

		; If a period (dot) is found then check whether or not the extension is equal to .au3.
		If $iExtension Then
			; If the extension isn't equal to .au3 then append to the end of the filepath.
			If Not (StringTrimLeft($sFileName, $iExtension - 1) = ".au3") Then $sFileSaveDialog &= ".au3"
		Else
			; If no period (dot) was found then append to the end of the file.
			$sFileSaveDialog &= ".au3"
		EndIf

		; Display the saved file.
		MsgBox($MB_SYSTEMMODAL, "", "You saved the following file:" & @CRLF & $sFileSaveDialog)
	EndIf
EndFunc   ;==>Example
