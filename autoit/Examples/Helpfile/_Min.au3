#include <Math.au3>
#include <MsgBoxConstants.au3>

Local $iMin = _Min(1, 10) ; Returns 1.
MsgBox($MB_SYSTEMMODAL, '', 'Minimum value: ' & $iMin)
