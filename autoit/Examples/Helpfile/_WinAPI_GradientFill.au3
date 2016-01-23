#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>

Local $aVertex[6][3] = [[0, 0, 0xFF0000], [400, 400, 0x00FF00], [0, 400, 0x0000FF], [0, 0, 0xFF0000], [400, 0, 0xFFFF00], [400, 400, 0x00FF00]]

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400)
Local $idPic = GUICtrlCreatePic('', 0, 0, 400, 400)
Local $hPic = GUICtrlGetHandle($idPic)

; Create gradient
Local $hDC = _WinAPI_GetDC($hPic)
Local $hDestDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmap($hDC, 400, 400)
Local $hDestSv = _WinAPI_SelectObject($hDestDC, $hBitmap)
_WinAPI_GradientFill($hDestDC, $aVertex, 0, 2)
_WinAPI_GradientFill($hDestDC, $aVertex, 3, 5)

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
