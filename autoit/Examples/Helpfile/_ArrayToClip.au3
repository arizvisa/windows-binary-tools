#include <Array.au3>
#include <MsgBoxConstants.au3>

Local $aArray = StringSplit("A,B,C,D,E,F,G,H,I", ",")
_ArrayDisplay($aArray, "1D Array")
_ArrayToClip($aArray, " - ", Default, 1, 6)
MsgBox($MB_SYSTEMMODAL, "_ArrayToClip() 1D Test", ClipGet())

Local $aArray[4][4]
For $i = 0 To 3
	For $j = 0 To 3
		$aArray[$i][$j] = $i & $j
	Next
Next
_ArrayDisplay($aArray, "2D Array")
_ArrayToClip($aArray, " :: ", Default, 1, 2, 1, 2)
MsgBox($MB_SYSTEMMODAL, "_ArrayToClip() 2D Test", ClipGet())
