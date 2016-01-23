#include <APIGdiConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>

Global Const $PI = 4 * ATan(1)

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 340, 340)
Local $idPic = GUICtrlCreatePic('', 0, 0, 320, 320)
Local $hPic = GUICtrlGetHandle($idPic)

; Create bitmap
Local $hDC = _WinAPI_GetDC($hPic)
Local $hMemDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmapEx($hDC, 340, 340, _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_3DFACE)))
Local $hMemSv = _WinAPI_SelectObject($hMemDC, $hBitmap)

; Set advanced graphics mode to be able to set the world transformation
_WinAPI_SetGraphicsMode($hMemDC, $GM_ADVANCED)

; Create transformation matrix for rotate of 5 degrees
Local $nAngle = $PI / 36
Local $iXc = 170
Local $iYc = 170
Local $nM11 = Cos($nAngle)
Local $nM12 = Sin($nAngle)
Local $nM21 = -$nM12
Local $nM22 = $nM11
Local $nDx = $iXc * (1 - Cos($nAngle)) + $iYc * Sin($nAngle)
Local $nDy = $iYc * (1 - Cos($nAngle)) - $iXc * Sin($nAngle)
Local $tXFORM = _WinAPI_CreateTransform($nM11, $nM12, $nM21, $nM22, $nDx, $nDy)

; Draw ellipses with rotation
Local $hBrush = _WinAPI_SelectObject($hMemDC, _WinAPI_GetStockObject($NULL_BRUSH))
Local $hPen = _WinAPI_SelectObject($hMemDC, _WinAPI_GetStockObject($DC_PEN))
_WinAPI_SetDCPenColor($hMemDC, 0xDD0000)
Local $tRECT = _WinAPI_CreateRect($iXc - 150, $iYc - 40, $iXc + 150, $iYc + 40)
For $i = 0 To 350 Step 5
	_WinAPI_ModifyWorldTransform($hMemDC, $tXFORM, $MWT_LEFTMULTIPLY)
	_WinAPI_Ellipse($hMemDC, $tRECT)
Next

; Release objects
_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_SelectObject($hMemDC, $hBrush)
_WinAPI_SelectObject($hMemDC, $hPen)
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
