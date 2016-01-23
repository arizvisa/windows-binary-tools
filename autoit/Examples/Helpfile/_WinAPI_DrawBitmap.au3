#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>

; Load image
Local $hSource = _WinAPI_LoadImage(0, @ScriptDir & '\Extras\Hatch.bmp', $IMAGE_BITMAP, 0, 0, $LR_LOADFROMFILE)
Local $tSIZE = _WinAPI_GetBitmapDimension($hSource)
Local $W = DllStructGetData($tSIZE, 'X')
Local $H = DllStructGetData($tSIZE, 'Y')

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), @DesktopWidth, @DesktopHeight, 0, 0, $WS_POPUP, $WS_EX_TOPMOST)
Local $idPic = GUICtrlCreatePic('', 0, 0, @DesktopWidth, @DesktopHeight)
Local $hPic = GUICtrlGetHandle($idPic)

; Create bitmap
Local $hDC = _WinAPI_GetDC($hPic)
Local $hDestDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmap($hDC, @DesktopWidth, @DesktopHeight)
Local $hDestSv = _WinAPI_SelectObject($hDestDC, $hBitmap)
For $i = 0 To Ceiling(@DesktopWidth / $W) - 1
	For $j = 0 To Ceiling(@DesktopHeight / $W) - 1
		_WinAPI_DrawBitmap($hDestDC, $i * $W, $j * $H, $hSource)
	Next
Next

_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_SelectObject($hDestDC, $hDestSv)
_WinAPI_DeleteObject($hSource)
_WinAPI_DeleteDC($hDestDC)

; Set bitmap to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
Local $hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
