#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>

Global $g_iCount = 0, $g_bColor = True
Local $hLineProc = DllCallbackRegister('_LineProc', 'none', 'int;int;lparam')
Local $pLineProc = DllCallbackGetPtr($hLineProc)

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 280, 280)
Local $idPic = GUICtrlCreatePic('', 0, 0, 281, 281)
Local $hPic = GUICtrlGetHandle($idPic)

; Create bitmap
Local $hDC = _WinAPI_GetDC($hPic)
Local $hMemDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmapEx($hDC, 280, 280, _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_3DFACE)))
Local $hMemSv = _WinAPI_SelectObject($hMemDC, $hBitmap)
_WinAPI_LineDDA(40, 40, 240, 40, $pLineProc, $hMemDC)
_WinAPI_LineDDA(240, 40, 240, 240, $pLineProc, $hMemDC)
_WinAPI_LineDDA(240, 240, 40, 240, $pLineProc, $hMemDC)
_WinAPI_LineDDA(40, 240, 40, 40, $pLineProc, $hMemDC)
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

DllCallbackFree($hLineProc)

Func _LineProc($iX, $iY, $hDC)
	If Not Mod($g_iCount, 10) Then
		$g_bColor = Not $g_bColor
	EndIf
	If $g_bColor Then
		_WinAPI_SetPixel($hDC, $iX, $iY, 0xFF0000)
	Else
		_WinAPI_SetPixel($hDC, $iX, $iY, 0xFFFFFF)
	EndIf
	$g_iCount += 1
EndFunc   ;==>_LineProc
