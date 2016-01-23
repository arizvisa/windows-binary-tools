#include <MsgBoxConstants.au3>

Local $dBinary = Binary("0x10203040") ; Create binary data from a string.
Local $dExtract = BinaryMid($dBinary, 2, 2)
MsgBox($MB_SYSTEMMODAL, "", "The 2nd and 3rd bytes are: " & $dExtract)
