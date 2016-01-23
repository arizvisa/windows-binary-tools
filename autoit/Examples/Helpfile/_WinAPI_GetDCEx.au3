#include <APIGdiConstants.au3>
#include <FontConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPISys.au3>
#include <WindowsConstants.au3>

Global $g_hFont = _WinAPI_CreateFont(16, 0, 0, 0, $FW_BOLD, 0, 0, 0, $DEFAULT_CHARSET, $OUT_DEFAULT_PRECIS, $CLIP_DEFAULT_PRECIS, $DEFAULT_PITCH, $ANTIALIASED_QUALITY, 'Arial')

Global $g_bDwm = False
If (_WinAPI_GetVersion() > '5.2') And (_WinAPI_DwmIsCompositionEnabled()) Then
	If MsgBox(BitOR($MB_YESNOCANCEL, $MB_ICONQUESTION, $MB_SYSTEMMODAL), 'DWM', 'This example works only if a Desktop Window Manager (DWM) composition is disabled.' & @CRLF & @CRLF & 'Do you want to disable DWM?') = 6 Then
		_WinAPI_DwmEnableComposition(0)
		$g_bDwm = True
	Else
		Exit
	EndIf
EndIf

OnAutoItExitRegister('OnAutoItExit')

; Create GUI
Global $g_hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400)

; Register window proc
Global $g_hDll = DllCallbackRegister('_WinProc', 'ptr', 'hwnd;uint;long;ptr')
Local $pDll = DllCallbackGetPtr($g_hDll)
Global $g_hProc = _WinAPI_SetWindowLong($g_hForm, $GWL_WNDPROC, $pDll)

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func _WinProc($hWnd, $iMsg, $wParam, $lParam)
	Local $vRes = _WinAPI_CallWindowProc($g_hProc, $hWnd, $iMsg, $wParam, $lParam)

	Switch $iMsg
		Case $WM_NCACTIVATE, $WM_NCPAINT
			Local $hDC
			Switch $iMsg
				Case $WM_NCACTIVATE
					$hDC = _WinAPI_GetWindowDC($hWnd)
				Case $WM_NCPAINT
					$hDC = _WinAPI_GetDCEx($hWnd, $wParam, BitOR($DCX_WINDOW, $DCX_INTERSECTRGN))
			EndSwitch
			Local $hSv = _WinAPI_SelectObject($hDC, $g_hFont)
			_WinAPI_SetTextColor($hDC, 0x00FFFF)
			_WinAPI_SetBkMode($hDC, $TRANSPARENT)
			_WinAPI_TextOut($hDC, 25, 8, 'Test ' & StringReplace(@ScriptName, '.au3', '()'))
			_WinAPI_SelectObject($hDC, $hSv)
			_WinAPI_ReleaseDC($hWnd, $hDC)
	EndSwitch
	Return $vRes
EndFunc   ;==>_WinProc

Func OnAutoItExit()
	_WinAPI_SetWindowLong($g_hForm, $GWL_WNDPROC, $g_hProc)
	DllCallbackFree($g_hDll)
	If $g_bDwm Then
		_WinAPI_DwmEnableComposition(1)
	EndIf
EndFunc   ;==>OnAutoItExit
