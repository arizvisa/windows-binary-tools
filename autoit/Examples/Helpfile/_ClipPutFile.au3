#include <Misc.au3>
#include <MsgBoxConstants.au3>

; Add the following contents to the clipboard.
Local $bReturn = _ClipPutFile(@ScriptFullPath & "|" & @ScriptDir & "|" & @SystemDir)
If Not $bReturn Then
	MsgBox($MB_SYSTEMMODAL, "_ClipPutFile() call Failed", "@error = " & @error)
Else
	MsgBox($MB_SYSTEMMODAL, "_ClipPutFile()", "Content of Clipboard:" & @CRLF & ClipGet())
EndIf
