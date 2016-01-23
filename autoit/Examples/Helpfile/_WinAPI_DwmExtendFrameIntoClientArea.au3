#include <GUIConstantsEx.au3>
#include <GUITab.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPITheme.au3>
#include <WindowsConstants.au3>

Opt('TrayAutoPause', 0)

If Not _WinAPI_DwmIsCompositionEnabled() Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later with enabled Aero theme.')
	Exit
EndIf

Global Const $PRF_CLIENT = 0x04

OnAutoItExitRegister('OnAutoItExit')

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400)
GUICtrlCreateTab(0, 60, 402, 341, $WS_CLIPCHILDREN)
Global $g_hTab = GUICtrlGetHandle(-1)
GUICtrlCreateTabItem('Tab 1')
GUICtrlCreateButton('Button', 150, 167, 100, 26)
_WinAPI_SetParent(GUICtrlGetHandle(-1), $g_hTab)
GUICtrlCreateTabItem('Tab 2')
GUICtrlCreateEdit('', 14, 34, 372, 292)
_WinAPI_SetParent(GUICtrlGetHandle(-1), $g_hTab)
GUICtrlCreateTabItem('Tab 3')
GUICtrlCreateTabItem('')
GUISetBkColor(0)

; Register Tab window proc
Global $g_hDll = DllCallbackRegister('_WinProc', 'ptr', 'hwnd;uint;wparam;lparam')
Local $pDll = DllCallbackGetPtr($g_hDll)
Global $g_hProc = _WinAPI_SetWindowLong($g_hTab, $GWL_WNDPROC, $pDll)

; Create the "sheet of glass" effect for the Tab client area. You must call this function whenever DWM composition is toggled.
_WinAPI_DwmExtendFrameIntoClientArea($hForm, _WinAPI_CreateMargins(2, 2, 82, 2))

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func _CreateClipRgn($hWnd)
	Local $tRECT, $hTmp, $iHt
	Local $iCount = _GUICtrlTab_GetItemCount($hWnd)
	Local $iSel = _GUICtrlTab_GetCurSel($hWnd)
	Local $hRgn = _WinAPI_CreateNullRgn()
	For $i = 0 To $iCount - 1
		$tRECT = _GUICtrlTab_GetItemRectEx($hWnd, $i)
		If $i = $iSel Then
			$hTmp = _WinAPI_CreateRectRgn(DllStructGetData($tRECT, 1) - 2, DllStructGetData($tRECT, 2) - 2, DllStructGetData($tRECT, 3) + 2, DllStructGetData($tRECT, 4))
			$iHt = DllStructGetData($tRECT, 4) - DllStructGetData($tRECT, 2) + 2
		Else
			If $i = $iCount - 1 Then
				$hTmp = _WinAPI_CreateRectRgn(DllStructGetData($tRECT, 1), DllStructGetData($tRECT, 2), DllStructGetData($tRECT, 3) - 2, DllStructGetData($tRECT, 4))
			Else
				$hTmp = _WinAPI_CreateRectRgn(DllStructGetData($tRECT, 1), DllStructGetData($tRECT, 2), DllStructGetData($tRECT, 3), DllStructGetData($tRECT, 4))
			EndIf
		EndIf
		_WinAPI_CombineRgn($hRgn, $hRgn, $hTmp, $RGN_OR)
		_WinAPI_DeleteObject($hTmp)
	Next
	$tRECT = _WinAPI_GetClientRect($hWnd)
	$hTmp = _WinAPI_CreateRectRgn(DllStructGetData($tRECT, 1), DllStructGetData($tRECT, 2) + $iHt, DllStructGetData($tRECT, 3) - 2, DllStructGetData($tRECT, 4) - 1)
	_WinAPI_CombineRgn($hRgn, $hRgn, $hTmp, $RGN_OR)
	_WinAPI_DeleteObject($hTmp)
	Return $hRgn
EndFunc   ;==>_CreateClipRgn

Func _WinProc($hWnd, $iMsg, $wParam, $lParam)
	If _WinAPI_IsThemeActive() Then
		Local $hRgn
		Switch $iMsg
			Case $WM_ERASEBKGND
				Local $hPrev = _WinAPI_GetClipRgn($wParam)
				$hRgn = _CreateClipRgn($hWnd)
				_WinAPI_ExtSelectClipRgn($wParam, $hRgn, $RGN_DIFF)
				Local $tRECT = _WinAPI_GetClientRect($hWnd)
				Local $hBrush = _WinAPI_CreateSolidBrush(0)
				_WinAPI_FillRect($wParam, $tRECT, $hBrush)
				_WinAPI_SelectClipRgn($wParam, $hPrev)
				_WinAPI_DeleteObject($hBrush)
				_WinAPI_DeleteObject($hRgn)
				Return 1
			Case $WM_PAINT
				Local $tPAINTSTRUCT
				Local $hDC = _WinAPI_BeginPaint($hWnd, $tPAINTSTRUCT)
				$hRgn = _CreateClipRgn($hWnd)
				_WinAPI_ExtSelectClipRgn($hDC, $hRgn, $RGN_AND)
				_WinAPI_CallWindowProc($g_hProc, $hWnd, $WM_PRINTCLIENT, $hDC, $PRF_CLIENT)
				_WinAPI_DeleteObject($hRgn)
				_WinAPI_EndPaint($hWnd, $tPAINTSTRUCT)
				Return 0
		EndSwitch
	EndIf
	Return _WinAPI_CallWindowProc($g_hProc, $hWnd, $iMsg, $wParam, $lParam)
EndFunc   ;==>_WinProc

Func OnAutoItExit()
	_WinAPI_SetWindowLong($g_hTab, $GWL_WNDPROC, $g_hProc)
	DllCallbackFree($g_hDll)
EndFunc   ;==>OnAutoItExit
