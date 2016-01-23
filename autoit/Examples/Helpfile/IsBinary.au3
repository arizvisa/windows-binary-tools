#include <MsgBoxConstants.au3>

Local $dBinary = Binary("0x00204060")
Local $sString = "0x00204060"

MsgBox($MB_SYSTEMMODAL, "", "Returns 1 as the variable is binary: " & IsBinary($dBinary))
MsgBox($MB_SYSTEMMODAL, "", "Returns 0 as the variable is a string: " & IsBinary($sString))
