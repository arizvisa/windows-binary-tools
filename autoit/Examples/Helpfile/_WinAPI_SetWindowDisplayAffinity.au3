#include <APIGdiConstants.au3>
#include <APISysConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <ScreenCapture.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPISys.au3>
#include <WindowsConstants.au3>

If (_WinAPI_GetVersion() < '6.1') Or (Not _WinAPI_DwmIsCompositionEnabled()) Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows 7 or later with enabled Aero theme.')
	Exit
EndIf

Global $g_iWidth = @DesktopWidth / 2, $g_iHeight = @DesktopHeight / 2

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), $g_iWidth + 116, $g_iHeight + 51)
GUICtrlCreatePic('', 14, 14, $g_iWidth + 2, $g_iHeight + 2, -1, $WS_EX_STATICEDGE)
GUICtrlSetState(-1, $GUI_DISABLE)
Global $g_hPic = GUICtrlGetHandle(-1)
Local $idCheck = GUICtrlCreateCheckbox('Protect against capture of window', 14, $g_iHeight + 23, 182, 21)
Local $idButton = GUICtrlCreateButton('Capture', $g_iWidth + 29, 13, 74, 25)
GUICtrlSetState(-1, BitOR($GUI_DEFBUTTON, $GUI_FOCUS))
GUISetState(@SW_SHOW)

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $idButton
			_Capture()
		Case $idCheck
			If GUICtrlRead($idCheck) = $GUI_CHECKED Then
				_WinAPI_SetWindowDisplayAffinity($hForm, $WDA_MONITOR)
			Else
				_WinAPI_SetWindowDisplayAffinity($hForm, 0)
			EndIf
	EndSwitch
WEnd

Func _Capture()
	Local $hObj = _SendMessage($g_hPic, $STM_SETIMAGE, 0, 0)
	If $hObj Then
		_WinAPI_DeleteObject($hObj)
	EndIf
	Local $hDC = _WinAPI_GetDC($g_hPic)
	Local $hDestDC = _WinAPI_CreateCompatibleDC($hDC)
	Local $hBitmap = _WinAPI_CreateCompatibleBitmap($hDC, $g_iWidth, $g_iHeight)
	Local $hDestSv = _WinAPI_SelectObject($hDestDC, $hBitmap)
	Local $hSrcDC = _WinAPI_CreateCompatibleDC($hDC)
	$hObj = _ScreenCapture_Capture('', 0, 0, -1, -1, 0)
	Local $hSrcSv = _WinAPI_SelectObject($hSrcDC, $hObj)
	_WinAPI_SetStretchBltMode($hDestDC, $HALFTONE)
	_WinAPI_StretchBlt($hDestDC, 0, 0, $g_iWidth, $g_iHeight, $hSrcDC, 0, 0, @DesktopWidth, @DesktopHeight, $SRCCOPY)
	_WinAPI_ReleaseDC($g_hPic, $hDC)
	_WinAPI_SelectObject($hDestDC, $hDestSv)
	_WinAPI_DeleteDC($hDestDC)
	_WinAPI_SelectObject($hSrcDC, $hSrcSv)
	_WinAPI_DeleteObject($hObj)
	_WinAPI_DeleteDC($hSrcDC)
	_SendMessage($g_hPic, $STM_SETIMAGE, 0, $hBitmap)
	$hObj = _SendMessage($g_hPic, $STM_GETIMAGE)
	If $hObj <> $hBitmap Then
		_WinAPI_DeleteObject($hBitmap)
	EndIf
EndFunc   ;==>_Capture
