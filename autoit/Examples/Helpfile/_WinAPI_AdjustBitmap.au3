#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>

; Load and resize (x2) image
Local $hBitmap = _WinAPI_LoadImage(0, @ScriptDir & '\Extras\AutoIt.bmp', $IMAGE_BITMAP, 0, 0, $LR_LOADFROMFILE)
Local $tSIZE = _WinAPI_GetBitmapDimension($hBitmap)
Local $W = 2 * DllStructGetData($tSIZE, 'X')
Local $H = 2 * DllStructGetData($tSIZE, 'Y')
Local $hResize = _WinAPI_AdjustBitmap($hBitmap, $W, $H)
_WinAPI_DeleteObject($hBitmap)

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), $W, $H)
Local $idPic = GUICtrlCreatePic('', 0, 0, $W, $H)
Local $hPic = GUICtrlGetHandle($idPic)

; Set bitmap to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hResize)
Local $hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hResize Then
	_WinAPI_DeleteObject($hResize)
EndIf

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
