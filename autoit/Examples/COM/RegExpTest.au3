#include <MsgBoxConstants.au3>

; COM test file
;
; Regular Expression test using VBScript.RegExp object
;
; Source: http://msdn.microsoft.com/library/en-us/script56/html/vsobjregexp.asp

MsgBox($MB_SYSTEMMODAL, "Test RegExp", RegExpTest("is.", "IS1 is2 IS3 is4"))

Func RegExpTest($sPatrn, $s)
	Local $sRet = ""

	Local $oRegEx = ObjCreate("VBScript.RegExp") ; Create a regular expression.

	$oRegEx.Pattern = $sPatrn ; Set pattern.
	$oRegEx.IgnoreCase = 1 ; Set case insensitivity: True.
	$oRegEx.Global = 1 ; Set global applicability: True.
	Local $oMatches = $oRegEx.Execute($s) ; Execute search.

	For $oMatch In $oMatches ; Iterate Matches collection.
		$sRet = $sRet & "Match found at position "
		$sRet = $sRet & $oMatch.FirstIndex & ". Match Value is '"
		$sRet = $sRet & $oMatch.Value & "'." & @CRLF
	Next

	$oRegEx = ""

	Return $sRet
EndFunc   ;==>RegExpTest
