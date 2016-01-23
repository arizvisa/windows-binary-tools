#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 281, 281)
Local $idPic = GUICtrlCreatePic('', 0, 0, 281, 281)
Local $hPic = GUICtrlGetHandle($idPic)

; Create bitmap
Local $hDC = _WinAPI_GetDC($hPic)
Local $hMemDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmapEx($hDC, 281, 281, _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_3DFACE)))
Local $hMemSv = _WinAPI_SelectObject($hMemDC, $hBitmap)
Local $hRgn = _WinAPI_CreateEllipticRgn(_WinAPI_CreateRectEx(40, 40, 201, 201))
_WinAPI_SelectClipRgn($hMemDC, $hRgn)
Local $aVertex[3][3] = [[140, -50, 0xFFFF00], [-50, 244, 0x00F0FF], [331, 244, 0xFF00FF]]
_WinAPI_GradientFill($hMemDC, $aVertex)
_WinAPI_DeleteObject($hRgn)
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
