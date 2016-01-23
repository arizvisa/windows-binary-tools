#include <APIGdiConstants.au3>
#include <Array.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>

Local $aRamp, $iRgb = 0xFF0000

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 256, 256)
GUICtrlCreatePic('', 0, 0, 256, 256)
Local $hPic = GUICtrlGetHandle(-1)

; Retrieve current gamma ramp and create graph of lookup table (LUT)
Local $hDC = _WinAPI_GetDC(0)
Local $hMemDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmapEx($hDC, 256, 256, 0)
Local $hSv1 = _WinAPI_SelectObject($hMemDC, $hBitmap)
Local $hPen = _WinAPI_GetStockObject($DC_PEN)
Local $hSv2 = _WinAPI_SelectObject($hMemDC, $hPen)
_WinAPI_SetROP2($hMemDC, $R2_XORPEN)
_WinAPI_GetDeviceGammaRamp($hDC, $aRamp)
_WinAPI_ReleaseDC(0, $hDC)
If IsArray($aRamp) Then
	For $i = 0 To 2
		_WinAPI_SetDCPenColor($hMemDC, BitShift($iRgb, 8 * $i))
		For $j = 0 To 255
			If $j Then
				_WinAPI_LineTo($hMemDC, $j + 1, Round(255 * (1 - $aRamp[$j][$i] / 65280)) - 1)
			Else
				_WinAPI_MoveTo($hMemDC, 0, Round(255 * (1 - $aRamp[$j][$i] / 65280)))
			EndIf
		Next
	Next
EndIf
_WinAPI_SetDCPenColor($hMemDC, 0x404040)
_WinAPI_SetROP2($hMemDC, $R2_MERGEPEN)
For $i = 64 To 192 Step 64
	_WinAPI_DrawLine($hMemDC, $i - 1, 0, $i - 1, 256)
	_WinAPI_DrawLine($hMemDC, 0, $i, 256, $i)
Next
_WinAPI_SelectObject($hMemDC, $hSv1)
_WinAPI_SelectObject($hMemDC, $hSv2)
_WinAPI_DeleteObject($hPen)
_WinAPI_DeleteDC($hMemDC)

; Set bitmap to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
Local $hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

GUISetState(@SW_SHOW)

If IsArray($aRamp) Then
	_ArrayDisplay($aRamp, '_WinAPI_GetDeviceGammaRamp')
Else
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Your video board do not support loadable gamma ramps.', 0, $hForm)
EndIf

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
