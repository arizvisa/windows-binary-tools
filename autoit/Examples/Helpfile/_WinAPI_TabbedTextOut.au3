#include <FontConstants.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400)
Local $idPic = GUICtrlCreatePic('', 0, 0, 400, 400)
Local $hPic = GUICtrlGetHandle($idPic)

; Create bitmap
Local $hDev = _WinAPI_GetDC($hPic)
Local $hDC = _WinAPI_CreateCompatibleDC($hDev)
Local $hSource = _WinAPI_CreateCompatibleBitmapEx($hDev, 400, 400, _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_3DFACE)))
Local $hSv = _WinAPI_SelectObject($hDC, $hSource)

; Draw objects
Local $hOldBrush = _WinAPI_SelectObject($hDC, _WinAPI_GetStockObject($DC_BRUSH))
Local $hOldPen = _WinAPI_SelectObject($hDC, _WinAPI_GetStockObject($DC_PEN))

_WinAPI_SetTextColor($hDC, 0xCD0091)
_WinAPI_SetBkMode($hDC, $TRANSPARENT)
Local $hFont = _WinAPI_CreateFont(12, 0, 0, 0, $FW_NORMAL, 0, 0, 0, $DEFAULT_CHARSET, $OUT_DEFAULT_PRECIS, $CLIP_DEFAULT_PRECIS, $ANTIALIASED_QUALITY, $DEFAULT_PITCH, 'Arial Black')
Local $hObj = _WinAPI_SelectObject($hDC, $hFont)
_WinAPI_TextOut($hDC, 10, 15, 'Simple Text')
Local $sTabbedTextOut = 'Tabbed ' & @TAB & 'Text ' & @TAB & 'Out'
_WinAPI_TextOut($hDC, 10, 35, $sTabbedTextOut)
_WinAPI_TabbedTextOut($hDC, 10, 65, $sTabbedTextOut)
_WinAPI_SelectObject($hDC, $hObj)
_WinAPI_DeleteObject($hFont)

; ; Merge bitmap
Local $hBitmap = _WinAPI_CreateCompatibleBitmap($hDev, 400, 400)
Local $hBrush = _WinAPI_SelectObject($hDC, $hOldBrush)
_WinAPI_DeleteObject($hBrush)
Local $hPen = _WinAPI_SelectObject($hDC, $hOldPen)
_WinAPI_DeleteObject($hPen)
_WinAPI_SelectObject($hDC, $hBitmap)
_WinAPI_DrawBitmap($hDC, 0, 0, $hSource, $MERGECOPY)
_WinAPI_ReleaseDC($hPic, $hDev)
_WinAPI_SelectObject($hDC, $hSv)
_WinAPI_DeleteObject($hSource)
_WinAPI_DeleteDC($hDC)

; Set bitmap to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
$hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = -3
