#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3> ; Required for _ArrayDisplay only.

; Recursively display a list of files in a directory.
Example()

Func Example()
	Local $sFilePath = @ScriptDir ; Search the current script directory.
	Local $sFilter = "*.*" ; Search for all files in the current directory. For a list of valid wildcards, search for 'Wildcards' in the Help file.

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
	; If you want to search with files that contains unicode characters, then use the /U commandline parameter.

	; Wait until the process has closed using the PID returned by Run.
	ProcessWaitClose($iPID)

	; Read the Stdout stream of the PID returned by Run. This can also be done in a while loop. Look at the example for StderrRead.
	Local $sOutput = StdoutRead($iPID)

	; Use StringSplit to split the output of StdoutRead to an array. All carriage returns (@CRLF) are stripped and @CRLF (line feed) is used as the delimiter.
	Local $aArray = StringSplit(StringTrimRight(StringStripCR($sOutput), StringLen(@CRLF)), @CRLF)
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "It appears there was an error trying to find all the files in the current script directory.")
	Else
		; Display the results.
		_ArrayDisplay($aArray)
	EndIf
EndFunc   ;==>Example
