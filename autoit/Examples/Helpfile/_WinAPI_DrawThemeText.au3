#include <FontConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPI.au3>
#include <WinAPIGdi.au3>
#include <WinAPITheme.au3>
#include <WindowsConstants.au3>

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 160, 199)
Local $idPic = GUICtrlCreatePic('', 0, 0, 160, 199)
Local $hPic = GUICtrlGetHandle($idPic)

; Create bitmap
Local $hDev = _WinAPI_GetDC($hPic)
Local $hDC = _WinAPI_CreateCompatibleDC($hDev)
Local $hSource = _WinAPI_CreateCompatibleBitmapEx($hDev, 160, 199, _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_3DFACE)))
Local $hSv = _WinAPI_SelectObject($hDC, $hSource)

; Draw objects
Local $tRECT = _WinAPI_CreateRectEx(25, 25, 110, 25)
Local $hFont = _WinAPI_CreateFont(12, 0, 0, 0, $FW_NORMAL, 0, 0, 0, $DEFAULT_CHARSET, $OUT_DEFAULT_PRECIS, $CLIP_DEFAULT_PRECIS, $DEFAULT_QUALITY, $DEFAULT_PITCH, 'MS Shell Dlg')
_WinAPI_SetBkMode($hDC, $TRANSPARENT)
_WinAPI_SelectObject($hDC, $hFont)
Local $hTheme = _WinAPI_OpenThemeData($hForm, 'Button')
If Not @error Then
	For $i = 1 To 5
		_WinAPI_DrawThemeBackground($hTheme, 1, $i, $hDC, $tRECT)
		_WinAPI_DrawThemeText($hTheme, 1, $i, $hDC, 'OK', $tRECT, BitOR($DT_CENTER, $DT_SINGLELINE, $DT_VCENTER))
		_WinAPI_OffsetRect($tRECT, 0, 31)
	Next
	_WinAPI_CloseThemeData($hTheme)
EndIf

; Merge bitmap
Local $hBitmap = _WinAPI_CreateCompatibleBitmap($hDev, 160, 199)
_WinAPI_SelectObject($hDC, $hBitmap)
_WinAPI_DrawBitmap($hDC, 0, 0, $hSource, $MERGECOPY)
_WinAPI_ReleaseDC($hPic, $hDev)
_WinAPI_SelectObject($hDC, $hSv)
_WinAPI_DeleteObject($hSource)
_WinAPI_DeleteDC($hDC)

; Set bitmap to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
Local $hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
