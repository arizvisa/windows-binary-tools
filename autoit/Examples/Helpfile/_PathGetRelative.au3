#include <File.au3>

Example()

Func Example()
	Local $sFrom, $sTo, $sPath
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"
	Local $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt", "InstallDir")

	$sFrom = @ScriptDir
	ConsoleWrite("Source Path: " & $sFrom & @CRLF)
	$sTo = $sFile & "\autoit3.exe"
	ConsoleWrite("Dest Path: " & $sTo & @CRLF)
	$sPath = _PathGetRelative($sFrom, $sTo)
	If @error Then
		ConsoleWrite("Error: " & @error & @CRLF)
		ConsoleWrite("Path: " & $sPath & @CRLF)
	Else
		ConsoleWrite("Relative Path: " & $sPath & @CRLF)
		ConsoleWrite("Resolved Path: " & _PathFull($sFrom & "\" & $sPath) & @CRLF)
	EndIf
EndFunc   ;==>Example
