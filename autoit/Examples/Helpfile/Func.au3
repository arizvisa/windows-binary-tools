#include <Date.au3>
#include <Math.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Sample script with two user-defined functions.
	; Notice the use of variables, ByRef and Return.

	Local $iFoo = 2
	Local $iBar = 5
	MsgBox($MB_SYSTEMMODAL, "", "Today is " & Today() & @CRLF & "$iFoo equals " & $iFoo)
	Swap($iFoo, $iBar)
	MsgBox($MB_SYSTEMMODAL, "", "After swapping $iFoo and $iBar:" & @CRLF & "$iFoo now contains " & $iFoo)
	MsgBox($MB_SYSTEMMODAL, "", "Finally:" & @CRLF & "The larger of 3 and 4 is " & _Max(3, 4))
EndFunc   ;==>Example

Func Swap(ByRef $vVar1, ByRef $vVar2) ; Swap the contents of two variables.
	Local $vTemp = $vVar1
	$vVar1 = $vVar2
	$vVar2 = $vTemp
EndFunc   ;==>Swap

Func Today() ; Return the current date in mm/dd/yyyy form.
	Return @MON & "/" & @MDAY & "/" & @YEAR
EndFunc   ;==>Today
