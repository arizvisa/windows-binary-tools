#include <MsgBoxConstants.au3>

Local $dBinary = Binary("0x00204060") ; Convert the string to binary.

MsgBox($MB_SYSTEMMODAL, "", "Returns 1 as the variable is binary: " & IsBinary($dBinary))
