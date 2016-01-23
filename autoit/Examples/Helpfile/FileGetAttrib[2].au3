#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Assign a variable with the filepath to check on whether it's a file or not.
	Local $sFilePath = @ScriptFullPath

	If IsFile($sFilePath) Then
		MsgBox($MB_SYSTEMMODAL, "", "The filepath is a file.")
	Else
		MsgBox($MB_SYSTEMMODAL, "", "The filepath is not a file.")
	EndIf
EndFunc   ;==>Example

; Check if the filepath is a file. Does not validate if the file exists.
Func IsFile($sFilePath)
	Return StringInStr(FileGetAttrib($sFilePath), "D") = 0
EndFunc   ;==>IsFile
