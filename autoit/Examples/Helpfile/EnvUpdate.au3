#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Retrieve the system environment variable called %PATH%.
	Local $sEnvVar = EnvGet("PATH")

	; Assign the system environment variable called %PATH% with its current value as well as the script directory.
	; When you assign an environment variable you do so minus the percentage signs (%).
	EnvSet("PATH", $sEnvVar & ";" & @ScriptDir)

	; Refresh the OS environment for changes to take affect.
	EnvUpdate()

	; Retrieve the system environment variable that was just assigned a value previously.
	$sEnvVar = EnvGet("PATH")

	; Display the value of the environment variable $PATH%.
	MsgBox($MB_SYSTEMMODAL, "", "The environment variable %PATH% has the value of: " & $sEnvVar)
EndFunc   ;==>Example
