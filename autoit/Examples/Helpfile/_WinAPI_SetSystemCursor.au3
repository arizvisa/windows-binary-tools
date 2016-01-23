#include <WinAPIRes.au3>

Local $hPrev = _WinAPI_CopyCursor(_WinAPI_LoadCursor(0, 32512))

_WinAPI_SetSystemCursor(_WinAPI_LoadCursorFromFile(@ScriptDir & '\Extras\Lens.cur'), 32512)
Sleep(5000)
_WinAPI_SetSystemCursor($hPrev, 32512)
