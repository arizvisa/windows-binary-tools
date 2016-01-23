#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>

Local $a_idPic[2], $a_hPic[2], $a_hBitmap[2]

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 260, 140)
$a_idPic[0] = GUICtrlCreatePic('', 20, 20, 100, 100)
$a_idPic[1] = GUICtrlCreatePic('', 140, 20, 100, 100)
For $i = 0 To 1
	$a_hPic[$i] = GUICtrlGetHandle($a_idPic[$i])
Next

; Create bitmap1
Local $hDC = _WinAPI_GetDC($a_hPic[0])
Local $hDestDC = _WinAPI_CreateCompatibleDC($hDC)
$a_hBitmap[0] = _WinAPI_CreateCompatibleBitmapEx($hDC, 100, 100, 0xFF00FF)
Local $hDestSv = _WinAPI_SelectObject($hDestDC, $a_hBitmap[0])
Local $hObj = _WinAPI_CreateCompatibleBitmapEx($hDC, 70, 70, 0x00A060)
_WinAPI_DrawBitmap($hDestDC, 15, 15, $hObj)
_WinAPI_DeleteObject($hObj)
$hObj = _WinAPI_CreateCompatibleBitmapEx($hDC, 40, 40, 0xFF00FF)
_WinAPI_DrawBitmap($hDestDC, 30, 30, $hObj)
_WinAPI_DeleteObject($hObj)

_WinAPI_ReleaseDC($a_hPic[0], $hDC)
_WinAPI_SelectObject($hDestDC, $hDestSv)
_WinAPI_DeleteDC($hDestDC)

; Create bitmap2
$hDC = _WinAPI_GetDC($a_hPic[1])
$hDestDC = _WinAPI_CreateCompatibleDC($hDC)
$a_hBitmap[1] = _WinAPI_CreateCompatibleBitmapEx($hDC, 100, 100, _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_3DFACE)))
$hDestSv = _WinAPI_SelectObject($hDestDC, $a_hBitmap[1])
Local $hSrcDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hSrcSv = _WinAPI_SelectObject($hSrcDC, $a_hBitmap[0])
_WinAPI_TransparentBlt($hDestDC, 0, 0, 100, 100, $hSrcDC, 0, 0, 100, 100, 0xFF00FF)

_WinAPI_ReleaseDC($a_hPic[1], $hDC)
_WinAPI_SelectObject($hDestDC, $hDestSv)
_WinAPI_SelectObject($hSrcDC, $hSrcSv)
_WinAPI_DeleteDC($hDestDC)
_WinAPI_DeleteDC($hSrcDC)

; Set both bitmaps to controls
For $i = 0 To 1
	_SendMessage($a_hPic[$i], $STM_SETIMAGE, 0, $a_hBitmap[$i])
	$hObj = _SendMessage($a_hPic[$i], $STM_GETIMAGE)
	If $hObj <> $a_hBitmap[$i] Then
		_WinAPI_DeleteObject($a_hBitmap[$i])
	EndIf
Next

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
