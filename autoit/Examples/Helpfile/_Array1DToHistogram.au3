#include <Array.au3>

Local $aNEW[] = [0, -80, -49, -44, 80, 100, 8, 7, 6, 5, 4, 3, 2, 1]
Local $aArray = _Array1DToHistogram($aNEW, 125)
_ArrayDisplay($aArray, "_Array1DToHistogram")
