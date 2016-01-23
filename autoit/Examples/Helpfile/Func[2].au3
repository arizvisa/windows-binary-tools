#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Sample scriptusing @NumParams macro
	Test_Numparams(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14)
EndFunc   ;==>Example

Func Test_Numparams($vVar1 = 0, $vVar2 = 0, $vVar3 = 0, $vVar4 = 0, $vVar5 = 0, $vVar6 = 0, $vVar7 = 0, $vVar8 = 0, $vVar9 = 0, _
		$vVar10 = 0, $vVar11 = 0, $vVar12 = 0, $vVar13 = 0, $vVar14 = 0, $vVar15 = 0, $vVar16 = 0, $vVar17 = 0, $vVar18 = 0, $vVar19 = 0)
	#forceref $vVar1, $vVar2, $vVar3, $vVar4, $vVar5, $vVar6, $vVar7, $vVar8, $vVar9, $vVar10
	#forceref $vVar11, $vVar12, $vVar13, $vVar14, $vVar15, $vVar16, $vVar17, $vVar18, $vVar19
	Local $sVal = ""
	For $i = 1 To @NumParams
		$sVal &= Eval("vVar" & $i) & " "
	Next
	MsgBox($MB_SYSTEMMODAL, "", "@NumParams = " & @NumParams & @CRLF & @CRLF & $sVal)
EndFunc   ;==>Test_Numparams
