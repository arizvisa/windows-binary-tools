#include <WinAPIRes.au3>
#include <WinAPISys.au3>
#include <WindowsConstants.au3>

Local Const $sClass = 'MyWindowClass'
Local Const $sName = 'Test ' & StringReplace(@ScriptName, '.au3', '()')

Global $g_bExit = False

; Get module handle for the current process
Local $hInstance = _WinAPI_GetModuleHandle(0)

; Create a class cursor
Local $hCursor = _WinAPI_LoadCursor(0, 32512) ; IDC_ARROW

; Create a class icons (large and small)
Local $tIcons = DllStructCreate('ptr;ptr')
_WinAPI_ExtractIconEx(@SystemDir & '\shell32.dll', 130, DllStructGetPtr($tIcons, 1), DllStructGetPtr($tIcons, 2), 1)
Local $hIcon = DllStructGetData($tIcons, 1)
Local $hIconSm = DllStructGetData($tIcons, 2)

; Create DLL callback function (window procedure)
Local $hProc = DllCallbackRegister('_WndProc', 'lresult', 'hwnd;uint;wparam;lparam')

; Create and fill $tagWNDCLASSEX structure
Local $tWCEX = DllStructCreate($tagWNDCLASSEX & ';wchar szClassName[' & (StringLen($sClass) + 1) & ']')
DllStructSetData($tWCEX, 'Size', DllStructGetPtr($tWCEX, 'szClassName') - DllStructGetPtr($tWCEX))
DllStructSetData($tWCEX, 'Style', 0)
DllStructSetData($tWCEX, 'hWndProc', DllCallbackGetPtr($hProc))
DllStructSetData($tWCEX, 'ClsExtra', 0)
DllStructSetData($tWCEX, 'WndExtra', 0)
DllStructSetData($tWCEX, 'hInstance', $hInstance)
DllStructSetData($tWCEX, 'hIcon', $hIcon)
DllStructSetData($tWCEX, 'hCursor', $hCursor)
DllStructSetData($tWCEX, 'hBackground', _WinAPI_CreateSolidBrush(_WinAPI_GetSysColor($COLOR_3DFACE)))
DllStructSetData($tWCEX, 'MenuName', 0)
DllStructSetData($tWCEX, 'ClassName', DllStructGetPtr($tWCEX, 'szClassName'))
DllStructSetData($tWCEX, 'hIconSm', $hIconSm)
DllStructSetData($tWCEX, 'szClassName', $sClass)

; Register a window class
_WinAPI_RegisterClassEx($tWCEX)

; Create a window
_WinAPI_CreateWindowEx(0, $sClass, $sName, BitOR($WS_CAPTION, $WS_POPUPWINDOW, $WS_VISIBLE), (@DesktopWidth - 400) / 2, (@DesktopHeight - 400) / 2, 400, 400, 0)

While 1
	Sleep(100)
	If $g_bExit Then
		ExitLoop
	EndIf
WEnd

; Unregister window class and release unnecessary resources
_WinAPI_UnregisterClass($sClass, $hInstance)
_WinAPI_DestroyCursor($hCursor)
_WinAPI_DestroyIcon($hIcon)
_WinAPI_DestroyIcon($hIconSm)

DllCallbackFree($hProc)

; Func _WinAPI_DefWindowProcW($hWnd, $iMsg, $wParam, $lParam)
; Local $aRet = DllCall('user32.dll', 'lresult', 'DefWindowProcW', 'hwnd', $hWnd, 'uint', $iMsg, 'wparam', $wParam, 'lparam', $lParam)

; If @error Then
; Return SetError(1, 0, 0)
; EndIf
; Return $aRet[0]
; EndFunc   ;==>_WinAPI_DefWindowProcW

Func _WndProc($hWnd, $iMsg, $wParam, $lParam)
	Switch $iMsg
		Case $WM_CLOSE
			$g_bExit = True
	EndSwitch
	Return _WinAPI_DefWindowProcW($hWnd, $iMsg, $wParam, $lParam)
EndFunc   ;==>_WndProc
