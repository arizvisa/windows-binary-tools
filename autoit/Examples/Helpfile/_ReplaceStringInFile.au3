#include <File.au3>
#include <MsgBoxConstants.au3>

Local $sFind = "BEFORE"
Local $sReplace = "AFTER"

Local $sFileName = "C:\_ReplaceStringInFile.test"

Local $iMsg = "Hello Test " & $sFind & " Hello Test" & @CRLF
$iMsg &= "Hello Test" & @CRLF
$iMsg &= @CRLF
$iMsg &= $sFind

FileWrite($sFileName, $iMsg)

MsgBox($MB_SYSTEMMODAL, "BEFORE", $iMsg)

Local $iRetval = _ReplaceStringInFile($sFileName, $sFind, $sReplace)
If $iRetval = -1 Then
	MsgBox($MB_SYSTEMMODAL, "ERROR", "The pattern could not be replaced in file: " & $sFileName & " Error: " & @error)
	Exit
Else
	MsgBox($MB_SYSTEMMODAL, "INFO", "Found " & $iRetval & " occurances of the pattern: " & $sFind & " in the file: " & $sFileName)
EndIf

$iMsg = FileRead($sFileName, 1000)
MsgBox($MB_SYSTEMMODAL, "AFTER", $iMsg)
FileDelete($sFileName)
