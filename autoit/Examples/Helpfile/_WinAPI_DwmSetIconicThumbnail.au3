#include <APIGdiConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPISys.au3>
#include <WindowsConstants.au3>

If (_WinAPI_GetVersion() < '6.1') Or (Not _WinAPI_DwmIsCompositionEnabled()) Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows 7 or later with enabled Aero theme.')
	Exit
EndIf

; Load bitmap to create a thumbnail
Global $g_hAutoIt = _WinAPI_LoadImage(0, @ScriptDir & '\Extras\AutoIt.bmp', $IMAGE_BITMAP, 0, 0, BitOR($LR_LOADFROMFILE, $LR_CREATEDIBSECTION))

; Create GUI
Global $g_hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400)

; Set DWM window attributes to provide the iconic bitmap, and to always render the thumbnail and live preview using the iconic bitmap
_WinAPI_DwmSetWindowAttribute($g_hForm, $DWMWA_FORCE_ICONIC_REPRESENTATION, 1)
_WinAPI_DwmSetWindowAttribute($g_hForm, $DWMWA_HAS_ICONIC_BITMAP, 1)

; Register WM_DWMSENDICONICLIVEPREVIEWBITMAP window message to display live preview
GUIRegisterMsg($WM_DWMSENDICONICLIVEPREVIEWBITMAP, 'WM_DWMSENDICONICLIVEPREVIEWBITMAP')

; Register WM_DWMSENDICONICTHUMBNAIL window message to display thumbnail
GUIRegisterMsg($WM_DWMSENDICONICTHUMBNAIL, 'WM_DWMSENDICONICTHUMBNAIL')

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func _CreateThumbnail($hSource, $iWidth, $iHeight)
	Local $hBitmap = _WinAPI_CreateDIB($iWidth, $iHeight)
	Local $hDestDC = _WinAPI_CreateCompatibleDC(0)
	Local $hDestSv = _WinAPI_SelectObject($hDestDC, $hBitmap)
	Local $tSIZE = _WinAPI_GetBitmapDimension($hSource)
	Local $hSrcDC = _WinAPI_CreateCompatibleDC(0)
	Local $hSrcSv = _WinAPI_SelectObject($hSrcDC, $hSource)
	_WinAPI_SetStretchBltMode($hDestDC, $HALFTONE)
	_WinAPI_StretchBlt($hDestDC, 0, 0, $iWidth, $iHeight, $hSrcDC, 0, 0, DllStructGetData($tSIZE, 'X'), DllStructGetData($tSIZE, 'Y'), $SRCCOPY)
	_WinAPI_SelectObject($hDestDC, $hDestSv)
	_WinAPI_DeleteDC($hDestDC)
	_WinAPI_SelectObject($hSrcDC, $hSrcSv)
	_WinAPI_DeleteDC($hSrcDC)
	Return $hBitmap
EndFunc   ;==>_CreateThumbnail

Func WM_DWMSENDICONICLIVEPREVIEWBITMAP($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam, $lParam

	Switch $hWnd
		Case $g_hForm
			Local $hBitmap = _CreateThumbnail($g_hAutoIt, 400, 400)
			_WinAPI_DwmSetIconicLivePreviewBitmap($g_hForm, $hBitmap, 1)
			_WinAPI_DeleteObject($hBitmap)
			Return 0
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_DWMSENDICONICLIVEPREVIEWBITMAP

Func WM_DWMSENDICONICTHUMBNAIL($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam

	Switch $hWnd
		Case $g_hForm
			Local $W, $H, $hBitmap

			$W = _WinAPI_HiWord($lParam)
			$H = _WinAPI_LoWord($lParam)
			If $W > $H Then
				$W = $H
			Else
				$H = $W
			EndIf
			$hBitmap = _CreateThumbnail($g_hAutoIt, $W, $H)
			_WinAPI_DwmSetIconicThumbnail($g_hForm, $hBitmap, 1)
			_WinAPI_DeleteObject($hBitmap)
			Return 0
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_DWMSENDICONICTHUMBNAIL
