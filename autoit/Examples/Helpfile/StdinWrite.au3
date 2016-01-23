#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $iPID = Run("sort.exe", @SystemDir, @SW_HIDE, $STDIN_CHILD + $STDOUT_CHILD)

	; Write a string of items to be sorted to child sort.exe's Stdin.
	StdinWrite($iPID, "Banana" & @CRLF & "Elephant" & @CRLF & "Apple" & @CRLF & "Deer" & @CRLF & "Car" & @CRLF)

	; Calling StdinWrite without a second parameter closes the stream.
	StdinWrite($iPID)

	Local $sOutput = "" ; Store the output of StdoutRead to a variable.

	While 1
		$sOutput &= StdoutRead($iPID) ; Read the Stdout stream of the PID returned by Run.
		If @error Then ; Exit the loop if the process closes or StdoutRead returns an error.
			ExitLoop
		EndIf
	WEnd

	MsgBox($MB_SYSTEMMODAL, "", "The sorted string is: " & @CRLF & $sOutput)
EndFunc   ;==>Example
