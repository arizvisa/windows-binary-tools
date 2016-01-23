; == Option 4, global return, php/preg_match_all() style

#include <MsgBoxConstants.au3>
#include <StringConstants.au3>

Local $aArray = StringRegExp('F1oF2oF3o', '(F.o)*?', $STR_REGEXPARRAYGLOBALFULLMATCH)
Local $aMatch = 0
For $i = 0 To UBound($aArray) - 1
	$aMatch = $aArray[$i]
	For $j = 0 To UBound($aMatch) - 1
		MsgBox($MB_SYSTEMMODAL, "RegExp Test with Option 4 - " & $i & ',' & $j, $aMatch[$j])
	Next
Next
