; Example of using ASin with degrees
#include <Math.au3>
#include <MsgBoxConstants.au3>

Local $fDegree = _Degree(ASin(0.5))

MsgBox($MB_SYSTEMMODAL, Default, "ASin(0.5) = " & $fDegree & " degrees")
