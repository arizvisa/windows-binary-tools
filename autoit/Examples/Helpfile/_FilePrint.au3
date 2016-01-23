#include <File.au3>
#include <MsgBoxConstants.au3>

Local $sFilePath = FileOpenDialog("Print File", "", "Text Documents (*.txt)", 1)
If @error Then Exit

Local $iIsPrinted = _FilePrint($sFilePath)
If $iIsPrinted Then
	MsgBox($MB_SYSTEMMODAL, "", "The file was printed.")
Else
	MsgBox($MB_SYSTEMMODAL, "", "Error: " & @error & @CRLF & "The file was not printed.")
EndIf
