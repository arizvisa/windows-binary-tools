#include <MsgBoxConstants.au3>

Example()

Func Example()
	; These variables will enumerate from 0 to 2.
	Local Enum $eVar1, $eVar2, $eVar3
	MsgBox($MB_SYSTEMMODAL, "", "$eVar1 is equal to (0): " & $eVar1 & @CRLF & _
			"$eVar2 is equal to (1): " & $eVar2 & @CRLF & _
			"$eVar3 is equal to (2): " & $eVar3 & @CRLF)

	; These variables will enumerate from 1 to 2 and then $eVariant3 is set to 5 which will continue to
	; increment by 1.
	Local Enum $eVariant1 = 1, $eVariant2, $eVariant3 = 5, $eVariant4
	MsgBox($MB_SYSTEMMODAL, "", "$eVariant1 is equal to (1): " & $eVariant1 & @CRLF & _
			"$eVariant2 is equal to (2): " & $eVariant2 & @CRLF & _
			"$eVariant3 is equal to (5): " & $eVariant3 & @CRLF & _
			"$eVariant3 is equal to (6): " & $eVariant4 & @CRLF)

	; Multiply each enumeration by 2.
	Local Enum Step *2 $eFoo1, $eFoo2, $eFoo3, $eFoo4
	MsgBox($MB_SYSTEMMODAL, "", "$eFoo1 is equal to (1): " & $eFoo1 & @CRLF & _
			"$eFoo2 is equal to (2): " & $eFoo2 & @CRLF & _
			"$eFoo3 is equal to (4): " & $eFoo3 & @CRLF & _
			"$eFoo3 is equal to (8): " & $eFoo4 & @CRLF)
EndFunc   ;==>Example
