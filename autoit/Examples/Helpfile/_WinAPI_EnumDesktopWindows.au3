#include <Array.au3>
#include <WinAPIProc.au3>
#include <WinAPISys.au3>

Local $aData = _WinAPI_EnumDesktopWindows(_WinAPI_GetThreadDesktop(_WinAPI_GetCurrentThreadId()))

_ArrayDisplay($aData, '_WinAPI_EnumDesktopWindows')
