#include <APIGdiConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 241, 241)
Local $idPic = GUICtrlCreatePic('', 0, 0, 241, 241)
Local $hPic = GUICtrlGetHandle($idPic)

; Create bitmap
Local $hDC = _WinAPI_GetDC($hPic)
Local $hMemDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmapEx($hDC, 241, 241, _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_3DFACE)))
Local $hMemSv = _WinAPI_SelectObject($hMemDC, $hBitmap)

; Create path
_WinAPI_BeginPath($hMemDC)
_WinAPI_MoveTo($hMemDC, 220, 78)
_WinAPI_LineTo($hMemDC, 170, 218)
_WinAPI_LineTo($hMemDC, 70, 218)
_WinAPI_LineTo($hMemDC, 20, 78)
_WinAPI_SetArcDirection($hMemDC, $AD_CLOCKWISE)
_WinAPI_ArcTo($hMemDC, _WinAPI_CreateRectEx(49, 22, 143, 143), 49, 78, 192, 78)
_WinAPI_CloseFigure($hMemDC)
_WinAPI_Ellipse($hMemDC, _WinAPI_CreateRectEx(70, 44, 101, 101))
_WinAPI_Ellipse($hMemDC, _WinAPI_CreateRectEx(90, 64, 61, 61))
_WinAPI_EndPath($hMemDC)

; Stroke outline, and fills path's interior
Local $hBrush = _WinAPI_SelectObject($hMemDC, _WinAPI_GetStockObject($DC_BRUSH))
Local $hPen = _WinAPI_SelectObject($hMemDC, _WinAPI_GetStockObject($DC_PEN))
_WinAPI_SetDCBrushColor($hMemDC, 0xFFC000)
_WinAPI_SetDCPenColor($hMemDC, 0xDD0000)
_WinAPI_StrokeAndFillPath($hMemDC)

; Release objects
_WinAPI_DeleteObject(_WinAPI_SelectObject($hDC, $hBrush))
_WinAPI_DeleteObject(_WinAPI_SelectObject($hDC, $hPen))
_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_SelectObject($hMemDC, $hMemSv)
_WinAPI_DeleteDC($hMemDC)

; Set bitmap to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
Local $hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
