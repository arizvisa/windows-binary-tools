; Force download from www.autoitscript.com

; #RequireAdmin ; needed if storing in @systemdir is wanted

#include <MsgBoxConstants.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>

Local $sSQliteDll = _SQLite_Startup("", False, -1)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "SQLite Error", "'SQLite3.dll' Can't be Loaded!")
	Exit -1
EndIf

MsgBox($MB_SYSTEMMODAL, "SQLite3.dll Loaded", $sSQliteDll & " (" & _SQLite_LibVersion() & ")")
ConsoleWrite("_SQLite_LibVersion=" & _SQLite_LibVersion() & @CRLF)
_SQLite_Shutdown()
