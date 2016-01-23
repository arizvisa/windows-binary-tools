#include <MsgBoxConstants.au3>

Local $iCode = AscW("ß")
MsgBox($MB_SYSTEMMODAL, "", "Unicode code for ß: U+" & Hex($iCode, 6))
