#include <MsgBoxConstants.au3>
#include <StringConstants.au3>

Example()

Func Example()
	; Create a constant variable in Local scope to store the file attributes of the current script.
	Local Const $sAttribute = FileGetAttrib(@ScriptFullPath)

	; Display the string returned by FileGetAttrib.
	MsgBox($MB_SYSTEMMODAL, "", "The attribute string: " & @CRLF & $sAttribute)

	; Display the string returned by AttributeToString
	MsgBox($MB_SYSTEMMODAL, "", "The attribute string with easier to understand values: " & @CRLF & _
			AttributeToString($sAttribute))
EndFunc   ;==>Example

Func AttributeToString($sAttribute)
	; Create a 1d array of the file attribute letters by splitting the string at the comma (,).
	Local $aInput = StringSplit("R,A,S,H,N,D,O,C,T", ",")

	; Create a 1d array using the friendlier file attribute names by splitting the string at the comma (,).
	Local $aOutput = StringSplit("Read-only /, Archive /, System /, Hidden /" & _
			", Normal /, Directory /, Offline /, Compressed /, Temporary /", ",")

	; Loop through the attribute letters array to replace with the friendlier value e.g. A becomes Archive or S becomes System.
	For $i = 1 To $aInput[0]
		$sAttribute = StringReplace($sAttribute, $aInput[$i], $aOutput[$i], 0, $STR_CASESENSE)
	Next

	; Remove the single space and trailing forward slash.
	$sAttribute = StringTrimRight($sAttribute, 2)

	; Return the attribute string.
	Return $sAttribute
EndFunc   ;==>AttributeToString
