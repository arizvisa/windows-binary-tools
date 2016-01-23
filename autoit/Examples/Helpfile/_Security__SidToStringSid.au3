#include <MsgBoxConstants.au3>
#include <Security.au3>

Local $sAccount = @UserName
Local $tSID = _Security__GetAccountSid($sAccount)
Local $sStringSID = _Security__SidToStringSid($tSID)
MsgBox($MB_SYSTEMMODAL, "SID", "User = " & $sAccount & @CRLF & "SID = " & $sStringSID)
