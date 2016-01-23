#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>

; Load enhanced metafile (.emf) and retrieve it's dimension (x6)
Local $hEmf = _WinAPI_GetEnhMetaFile(@ScriptDir & '\Extras\Flag.emf')
Local $tSIZE = _WinAPI_GetEnhMetaFileDimension($hEmf)
Local $iWidth = 6 * DllStructGetData($tSIZE, 'X')
Local $iHeight = 6 * DllStructGetData($tSIZE, 'Y')

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), $iWidth, $iHeight)
Local $idPic = GUICtrlCreatePic('', 0, 0, $iWidth, $iHeight)
Local $hPic = GUICtrlGetHandle($idPic)

; Create bitmap from enhanced metafile
Local $hDC = _WinAPI_GetDC($hPic)
Local $hMemDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmapEx($hDC, $iWidth, $iHeight, _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_3DFACE)))
Local $hMemSv = _WinAPI_SelectObject($hMemDC, $hBitmap)
Local $tRECT = _WinAPI_CreateRectEx(0, 0, $iWidth, $iHeight)
_WinAPI_PlayEnhMetaFile($hMemDC, $hEmf, $tRECT)

_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_SelectObject($hMemDC, $hMemSv)
_WinAPI_DeleteDC($hMemDC)

; Release enhanced metafile
_WinAPI_DeleteEnhMetaFile($hEmf)

; Set bitmap to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
Local $hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
