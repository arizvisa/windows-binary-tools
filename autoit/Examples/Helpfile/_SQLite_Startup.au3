; SQLite.dll version must match

#include <MsgBoxConstants.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>

Local $sSQliteDll = _SQLite_Startup()
If @error Then
	MsgBox($MB_SYSTEMMODAL, "SQLite Error", "SQLite3.dll Can't be Loaded!" & @CRLF & @CRLF & _
			"Not FOUND in @SystemDir, @WindowsDir, @ScriptDir, @WorkingDir or from www.autoitscript.com")
	Exit -1
EndIf

MsgBox($MB_SYSTEMMODAL, "SQLite3.dll Loaded", $sSQliteDll & " (" & _SQLite_LibVersion() & ")")
ConsoleWrite("_SQLite_LibVersion=" & _SQLite_LibVersion() & @CRLF)
_SQLite_Shutdown()
