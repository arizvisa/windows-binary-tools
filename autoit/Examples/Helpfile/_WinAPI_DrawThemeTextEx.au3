#include <APIThemeConstants.au3>
#include <FontConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WinAPI.au3>
#include <WinAPIGdi.au3>
#include <WinAPITheme.au3>
#include <WindowsConstants.au3>

If Not _WinAPI_DwmIsCompositionEnabled() Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later with enabled Aero theme.')
	Exit
EndIf

OnAutoItExitRegister('OnAutoItExit')

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 240, 240)
GUICtrlCreateIcon(@ScriptDir & '\Extras\Soccer.ico', 0, 88, 68, 64, 64)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateLabel('', 70, 130, 100, 30)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetState(-1, $GUI_DISABLE)
Global $g_hLabel = GUICtrlGetHandle(-1)
GUISetBkColor(0)

; Register label window proc
Global $g_hDll = DllCallbackRegister('_WinProc', 'ptr', 'hwnd;uint;wparam;lparam')
Local $pDll = DllCallbackGetPtr($g_hDll)
Global $g_hProc = _WinAPI_SetWindowLong($g_hLabel, $GWL_WNDPROC, $pDll)

; Create the "sheet of glass" effect for the entire window. You must call this function whenever DWM composition is toggled.
_WinAPI_DwmExtendFrameIntoClientArea($hForm)

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func _DrawText($hDC, $sText, $tRECT)
	; Original idea by Authenticity
	Local $iWidth = DllStructGetData($tRECT, 3) - DllStructGetData($tRECT, 1)
	Local $iHeight = DllStructGetData($tRECT, 4) - DllStructGetData($tRECT, 2)

	Local $tDTTOPTS = DllStructCreate($tagDTTOPTS)
	DllStructSetData($tDTTOPTS, 'Size', DllStructGetSize($tDTTOPTS))
	DllStructSetData($tDTTOPTS, 'Flags', BitOR($DTT_TEXTCOLOR, $DTT_GLOWSIZE, $DTT_COMPOSITED))
	DllStructSetData($tDTTOPTS, 'clrText', 0x0000C0)
	DllStructSetData($tDTTOPTS, 'GlowSize', 12)

	Local $hMemDC = _WinAPI_CreateCompatibleDC($hDC)
	Local $hBitmap = _WinAPI_CreateDIB($iWidth, -$iHeight)
	Local $hSv1 = _WinAPI_SelectObject($hMemDC, $hBitmap)
	Local $hFont = _WinAPI_CreateFont(26, 0, 0, 0, $FW_NORMAL, 0, 0, 0, $DEFAULT_CHARSET, $OUT_DEFAULT_PRECIS, $CLIP_DEFAULT_PRECIS, $DEFAULT_QUALITY, $DEFAULT_PITCH, 'Segoe Script')
	Local $hSv2 = _WinAPI_SelectObject($hMemDC, $hFont)
	$tRECT = _WinAPI_CreateRect(0, 0, $iWidth, $iHeight)
	Local $hTheme = _WinAPI_OpenThemeData($hForm, 'Globals')

	_WinAPI_DrawThemeTextEx($hTheme, 0, 0, $hMemDC, $sText, $tRECT, BitOR($DT_CENTER, $DT_SINGLELINE, $DT_VCENTER), $tDTTOPTS)
	_WinAPI_BitBlt($hDC, 0, 0, $iWidth, $iHeight, $hMemDC, 0, 0, $SRCCOPY)

	_WinAPI_CloseThemeData($hTheme)
	_WinAPI_SelectObject($hMemDC, $hSv1)
	_WinAPI_DeleteObject($hBitmap)
	_WinAPI_SelectObject($hMemDC, $hSv2)
	_WinAPI_DeleteObject($hFont)
	_WinAPI_DeleteDC($hMemDC)
EndFunc   ;==>_DrawText

Func _WinProc($hWnd, $iMsg, $wParam, $lParam)
	Switch $iMsg
		Case $WM_PAINT
			Local $tPAINTSTRUCT
			Local $hDC = _WinAPI_BeginPaint($hWnd, $tPAINTSTRUCT)
			_DrawText($hDC, 'Soccer', _WinAPI_GetClientRect($hWnd))
			_WinAPI_EndPaint($hWnd, $tPAINTSTRUCT)
			Return 0
	EndSwitch
	Return _WinAPI_CallWindowProc($g_hProc, $hWnd, $iMsg, $wParam, $lParam)
EndFunc   ;==>_WinProc

Func OnAutoItExit()
	_WinAPI_SetWindowLong($g_hLabel, $GWL_WNDPROC, $g_hProc)
	DllCallbackFree($g_hDll)
EndFunc   ;==>OnAutoItExit
