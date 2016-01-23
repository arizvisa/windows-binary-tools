#include <Math.au3>
#include <MsgBoxConstants.au3>

Local $iMax = _Max(1, 10) ; Returns 10.
MsgBox($MB_SYSTEMMODAL, '', 'Maximum value: ' & $iMax)
