#include <File.au3>
#include <MsgBoxConstants.au3>

Local $iCountLines = _FileCountLines(@ScriptFullPath) ; Retrieve the number of lines in the current script.
MsgBox($MB_SYSTEMMODAL, "", "There are " & $iCountLines & " lines in this file.")
