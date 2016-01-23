#include <Color.au3>
#include <MsgBoxConstants.au3>

Local $iRedColor = _ColorGetRed(0x8080ff)
MsgBox($MB_SYSTEMMODAL, "AutoIt", $iRedColor)
