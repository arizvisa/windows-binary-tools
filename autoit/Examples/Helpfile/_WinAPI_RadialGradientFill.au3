#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400)
Local $idPic = GUICtrlCreatePic('', 0, 0, 400, 400)
Local $hPic = GUICtrlGetHandle($idPic)

; Create gradient
Local $hDC = _WinAPI_GetDC($hPic)
Local $hDestDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmapEx($hDC, 400, 400, 0xFFFFFF)
Local $hDestSv = _WinAPI_SelectObject($hDestDC, $hBitmap)
For $i = 0 To 315 Step 45
	_WinAPI_RadialGradientFill($hDestDC, 200, 200, 180, Random(0, 0xFFFFFF, 1), 0xFFFFFF, $i, $i + 45)
Next
_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_SelectObject($hDestDC, $hDestSv)
_WinAPI_DeleteDC($hDestDC)

; Set gradient to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
Local $hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
