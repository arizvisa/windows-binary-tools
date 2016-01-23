; Obtain current timeout value

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $iCurrentTimeout = _IELoadWaitTimeout()
MsgBox($MB_SYSTEMMODAL, "_IELoadWaitTimeout", $iCurrentTimeout / 1000 & " sec")
