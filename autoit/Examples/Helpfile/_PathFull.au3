#include <File.au3>
#include <MsgBoxConstants.au3>

Local $sTestPath = _PathFull(@ScriptDir & "\..\..\test")
MsgBox($MB_SYSTEMMODAL, "", @ScriptDir & @CRLF & $sTestPath)
