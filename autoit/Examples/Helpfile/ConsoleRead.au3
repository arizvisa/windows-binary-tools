#include <MsgBoxConstants.au3>

#cs
	Compile this script to "ConsoleRead.exe".
	Open a command prompt to the directory where ConsoleRead.exe resides.
	Type the following on the command line:
	echo Hello! | ConsoleRead.exe

	When invoked in a console window, the above command echos the text "Hello!"
	but instead of displaying it, the | tells the console to pipe it to the STDIN stream
	of the ConsoleRead.exe process.
#ce

Example()

Func Example()
	If Not @Compiled Then
		MsgBox($MB_SYSTEMMODAL, "", "This script must be compiled in order to run the example.")
		Exit
	EndIf

	Local $sOutput
	While True
		$sOutput &= ConsoleRead()
		If @error Then ExitLoop
		Sleep(25)
	WEnd
	MsgBox($MB_SYSTEMMODAL, "", "Received: " & @CRLF & @CRLF & $sOutput)
EndFunc   ;==>Example
