#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Assign a variable with the filepath to check on whether it's a directory/folder or not.
	Local $sFilePath = @ScriptDir

	If IsDir($sFilePath) Then
		MsgBox($MB_SYSTEMMODAL, "", "The filepath is a directory/folder.")
	Else
		MsgBox($MB_SYSTEMMODAL, "", "The filepath is not a directory/folder.")
	EndIf
EndFunc   ;==>Example

; Check if the filepath is a directory/folder. Does not validate if the directory/folder exists.
Func IsDir($sFilePath)
	Return StringInStr(FileGetAttrib($sFilePath), "D") > 0
EndFunc   ;==>IsDir
