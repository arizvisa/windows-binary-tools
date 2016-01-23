#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Assign a Local variable the search handle of all files in the current directory.
	Local $hSearch = FileFindFirstFile("*.*")

	; Check if the search was successful, if not display a message and return False.
	If $hSearch = -1 Then
		MsgBox($MB_SYSTEMMODAL, "", "Error: No files/directories matched the search pattern.")
		Return False
	EndIf

	; Assign a Local variable the empty string which will contain the files names found.
	Local $sFileName = "", $iResult = 0

	While 1
		$sFileName = FileFindNextFile($hSearch)
		; If there is no more file matching the search.
		If @error Then ExitLoop

		; Display the file name.
		$iResult = MsgBox(BitOR($MB_SYSTEMMODAL, $MB_OKCANCEL), "", "File: " & $sFileName)
		If $iResult <> $IDOK Then ExitLoop ; If the user clicks on the cancel/close button.
	WEnd

	; Close the search handle.
	FileClose($hSearch)
EndFunc   ;==>Example
