; open SQLite with a specific local file

#include <MsgBoxConstants.au3>
#include <SQLite.au3>

Local $sLocalSQLiteDll = "local SQLite.dll" ; to be change to an existing .dll to have no error

Local $sSQliteDll = _SQLite_Startup($sLocalSQLiteDll, False, 1)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "SQLite Error", "'SQLite3.dll' Can't be Loaded!")
	Exit -1
EndIf

MsgBox($MB_SYSTEMMODAL, "SQLite3.dll Loaded", $sSQliteDll & " (" & _SQLite_LibVersion() & ")")
ConsoleWrite("_SQLite_LibVersion=" & _SQLite_LibVersion() & @CRLF)
_SQLite_Shutdown()
