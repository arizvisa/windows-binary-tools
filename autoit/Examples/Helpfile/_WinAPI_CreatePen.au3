#include <WinAPI.au3>
#include <WindowsConstants.au3>

ShowCross(@DesktopWidth / 2, @DesktopHeight / 2, 20, 2, 0xFF, 3000)

Func ShowCross($iStart_x, $iStart_y, $iLength, $iWidth, $iColor, $iTime)
	Local $hDC, $hPen, $o_Orig

	$hDC = _WinAPI_GetWindowDC(0) ; DC of entire screen (desktop)
	$hPen = _WinAPI_CreatePen($PS_SOLID, $iWidth, $iColor)
	$o_Orig = _WinAPI_SelectObject($hDC, $hPen)

	_WinAPI_DrawLine($hDC, $iStart_x - $iLength, $iStart_y, $iStart_x - 5, $iStart_y) ; horizontal left
	_WinAPI_DrawLine($hDC, $iStart_x + $iLength, $iStart_y, $iStart_x + 5, $iStart_y) ; horizontal right
	_WinAPI_DrawLine($hDC, $iStart_x, $iStart_y - $iLength, $iStart_x, $iStart_y - 5) ; vertical up
	;	_WinAPI_DrawLine($hDC, $iStart_x, $iStart_y + $iLength, $iStart_x, $iStart_y + 5) ; vertical down
	_WinAPI_MoveTo($hDC, $iStart_x, $iStart_y + $iLength)
	_WinAPI_LineTo($hDC, $iStart_x, $iStart_y + 5)

	Sleep($iTime) ; show cross over screen for defined seconds

	; refresh desktop (clear cross)
	_WinAPI_RedrawWindow(_WinAPI_GetDesktopWindow(), 0, 0, $RDW_INVALIDATE + $RDW_ALLCHILDREN)

	; clear resources
	_WinAPI_SelectObject($hDC, $o_Orig)
	_WinAPI_DeleteObject($hPen)
	_WinAPI_ReleaseDC(0, $hDC)
EndFunc   ;==>ShowCross
