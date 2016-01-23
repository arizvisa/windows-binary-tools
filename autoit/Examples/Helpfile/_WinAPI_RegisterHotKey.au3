#include <APISysConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPISys.au3>
#include <WindowsConstants.au3>

Opt('TrayAutoPause', 0)

OnAutoItExitRegister('OnAutoItExit')

Local $hWnd = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'))
GUIRegisterMsg($WM_HOTKEY, 'WM_HOTKEY')

; Set ALT-D
_WinAPI_RegisterHotKey($hWnd, 0x0144, $MOD_ALT, 0x44)
; Set ESC
_WinAPI_RegisterHotKey($hWnd, 0x011B, 0, 0x1B)

While 1
	Sleep(1000)
WEnd

Func WM_HOTKEY($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam

	Switch _WinAPI_HiWord($lParam)
		Case 0x44
			MsgBox($MB_SYSTEMMODAL, '', 'You pressed ALT-D')
		Case 0x1B
			MsgBox($MB_SYSTEMMODAL, '', 'You pressed ESC')
			Exit
	EndSwitch
EndFunc   ;==>WM_HOTKEY

Func OnAutoItExit()
	_WinAPI_UnregisterHotKey($hWnd, 0x0144)
	_WinAPI_UnregisterHotKey($hWnd, 0x011B)
EndFunc   ;==>OnAutoItExit
