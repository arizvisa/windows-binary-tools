#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

; Find the executable that is associated with the AutoIt script.
MsgBox($MB_SYSTEMMODAL, "Find Executable", "File: " & @ScriptFullPath & @CRLF & "Executable: " & _WinAPI_FindExecutable(@ScriptName))
