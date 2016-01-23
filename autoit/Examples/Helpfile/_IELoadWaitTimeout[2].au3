; Set timeout to 1 minute (60000 milliseconds)

#include <IE.au3>
#include <MsgBoxConstants.au3>

_IELoadWaitTimeout(60000)

Local $iCurrentTimeout = _IELoadWaitTimeout()
MsgBox($MB_SYSTEMMODAL, "_IELoadWaitTimeout", $iCurrentTimeout / 1000 & " sec")
