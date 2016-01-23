#include <FontConstants.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $g_tRECT, $g_hFont, $g_hOldFont, $g_hDC

HotKeySet("{ESC}", "_Exit")

$g_tRECT = DllStructCreate($tagRect)
DllStructSetData($g_tRECT, "Left", 5)
DllStructSetData($g_tRECT, "Top", 5)
DllStructSetData($g_tRECT, "Right", 250)
DllStructSetData($g_tRECT, "Bottom", 50)

$g_hDC = _WinAPI_GetDC(0)
$g_hFont = _WinAPI_CreateFont(50, 0, 0, 0, 400, False, False, False, $DEFAULT_CHARSET, _
		$OUT_DEFAULT_PRECIS, $CLIP_DEFAULT_PRECIS, $DEFAULT_QUALITY, 0, 'Arial')
$g_hOldFont = _WinAPI_SelectObject($g_hDC, $g_hFont)

_WinAPI_SetTextColor($g_hDC, 0x0000FF)
_WinAPI_SetBkColor($g_hDC, 0x000000)
; comment next line to get black background instead of transparent one
_WinAPI_SetBkMode($g_hDC, $TRANSPARENT)

While 1
	_WinAPI_DrawText($g_hDC, "Hello world!", $g_tRECT, $DT_CENTER)
	Sleep(100)
WEnd

Func _Exit()
	_WinAPI_SelectObject($g_hDC, $g_hOldFont)
	_WinAPI_DeleteObject($g_hFont)
	_WinAPI_ReleaseDC(0, $g_hDC)
	_WinAPI_InvalidateRect(0, 0)
	$g_tRECT = 0
	Exit
EndFunc   ;==>_Exit
