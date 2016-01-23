#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Retrieve the following text file. This can be found in the include folder which is in the installation path of AutoIt.
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"
	Local $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\include\_ReadMe_.txt"

	; Execute the readme file (.txt) with the default editor used for text files in Windows.
	Local $iPID = ShellExecute($sFile)

	MsgBox($MB_SYSTEMMODAL, "", "PID: " & $iPID)
EndFunc   ;==>Example
