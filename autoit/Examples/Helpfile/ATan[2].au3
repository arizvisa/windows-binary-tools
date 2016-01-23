; Example of using ATan with degrees
#include <Math.au3>
#include <MsgBoxConstants.au3>

Local $fDegree = _Degree(ATan(1))

MsgBox($MB_SYSTEMMODAL, Default, "ATan(1) = " & $fDegree & " degrees")
