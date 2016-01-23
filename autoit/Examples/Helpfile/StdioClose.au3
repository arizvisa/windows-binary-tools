#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3> ; Required for _ArrayDisplay only.

; Recursively display a list of files in a directory.
Example()

Func Example()
	Local $sFilePath = @ScriptDir ; Search the current script directory.
	Local $sFilter = "*.*" ; Search for all files in the current directory. For a list of valid wildcards, search for 'Wildcards' in the Help file.
	Local $sOutput = "" ; Store the output of StdoutRead to a variable.

	; If the file path isn't a directory then return from the 'Example' function.
	If Not StringInStr(FileGetAttrib($sFilePath), "D") Then
		Return SetError(1, 0, 0)
	EndIf

	; Remove trailing backslashes and append a single trailing backslash.
	$sFilePath = StringRegExpReplace($sFilePath, "[\\/]+\z", "") & "\"

	#cs
		Commandline parameters for DIR:
		/B - Simple output.
		/A-D - Search for all files, minus folders.
		/S - Search within subfolders.
	#ce
	Local $iPID = Run(@ComSpec & ' /C DIR "' & $sFilePath & $sFilter & '" /B /A-D /S', $sFilePath, @SW_HIDE, $STDOUT_CHILD)

	; Close the Stdio stream of the PID returned by Run. This will cause the message box to display due to not being able to read the stdout stream.
	StdioClose($iPID)

	While 1
		$sOutput &= StdoutRead($iPID) ; Read the Stdout stream of the PID returned by Run.
		If @error Then ; Exit the loop if the process closes or StdoutRead returns an error.
			ExitLoop
		EndIf
	WEnd

	; Use StringSplit to split the output of StdoutRead to an array. All carriage returns (@CRLF) are stripped and @CRLF (line feed) is used as the delimiter.
	Local $aArray = StringSplit(StringTrimRight(StringStripCR($sOutput), StringLen(@CRLF)), @CRLF)
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "It appears there was an error trying to find all the files in the current script directory.")
	Else
		; Display the results.
		_ArrayDisplay($aArray)
	EndIf
EndFunc   ;==>Example
