#include <MsgBoxConstants.au3>

; COM  test file
;
; Word Automation Example
;

Example()
Exit

Func Example()

	Local $oWord = ObjCreate("Word.Application")
	If IsObj($oWord) Then
		MsgBox($MB_SYSTEMMODAL, "WordTest", "Your Word Version is : " & $oWord.Version)
		MsgBox($MB_SYSTEMMODAL, "WordTest", "Build: " & $oWord.Build)

		$oWord.Quit ; Get rid of Word
	Else
		MsgBox($MB_SYSTEMMODAL, "WordTest", "Chceck if you have MS Word installed")
	EndIf

EndFunc   ;==>Example
