#include <Color.au3>
#include <MsgBoxConstants.au3>

Local $iBlueColor = _ColorGetBlue(0x8080ff)
MsgBox($MB_SYSTEMMODAL, "AutoIt", $iBlueColor)
