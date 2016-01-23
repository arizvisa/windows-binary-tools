#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

MsgBox($MB_SYSTEMMODAL, "Handle", "Get Foreground Window: " & _WinAPI_GetForegroundWindow())
