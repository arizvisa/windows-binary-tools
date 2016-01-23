#include <MsgBoxConstants.au3>

Local $dBinary = Binary("0x10203040") ; Create binary data from a string.
MsgBox($MB_SYSTEMMODAL, "", "The length of the binary is: " & BinaryLen($dBinary))
