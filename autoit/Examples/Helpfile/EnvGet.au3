#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Retrieve the value of the environment variable %APPDATA%.
	; When you assign or retrieve an envorinment variable you do so minus the percentage signs (%).
	Local $sEnvVar = EnvGet("APPDATA")

	; Display the value of the environment variable %APPDATA%.
	MsgBox($MB_SYSTEMMODAL, "", "The environment variable %APPDATA% has the value of: " & @CRLF & @CRLF & $sEnvVar) ; This returns the same value as the macro @AppDataDir does.
EndFunc   ;==>Example
