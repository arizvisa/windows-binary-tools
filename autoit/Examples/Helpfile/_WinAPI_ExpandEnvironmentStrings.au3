#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

MsgBox($MB_SYSTEMMODAL, "Environment string", "%windir% = " & _WinAPI_ExpandEnvironmentStrings("%windir%"))
