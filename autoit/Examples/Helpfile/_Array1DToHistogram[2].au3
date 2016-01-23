#include <Array.au3>

Local $iLimit = 500
Local $aValues[51]
Local $t, $n

For $i = 1 To $iLimit
	$t = TimerInit()
	Sleep(10)
	$n = Round(TimerDiff($t))
	$aValues[$n] += 1
Next
Local $aArray = _Array1DToHistogram($aValues)
_ArrayDisplay($aArray, "_Array1DToHistogram", "10:20")
