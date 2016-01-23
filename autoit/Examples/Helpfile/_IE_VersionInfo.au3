; Retrieve and display IE.au3 version information

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $aVersion = _IE_VersionInfo()
MsgBox($MB_SYSTEMMODAL, "IE.au3 Version", $aVersion[5] & " released " & $aVersion[4])
