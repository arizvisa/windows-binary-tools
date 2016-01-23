#include <APISysConstants.au3>
#include <WinAPISys.au3>

Opt('TrayAutoPause', 0)

OnAutoItExitRegister('OnAutoItExit')

Global $g_hForm = GUICreate('')
GUIRegisterMsg(_WinAPI_RegisterWindowMessage('SHELLHOOK'), 'WM_SHELLHOOK')
_WinAPI_RegisterShellHookWindow($g_hForm)

While 1
	Sleep(1000)
WEnd

Func WM_SHELLHOOK($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg

	Switch $hWnd
		Case $g_hForm
			Local $sTitle = WinGetTitle($lParam)
			Switch $wParam
				Case $HSHELL_REDRAW
					If IsString($sTitle) Then
						ConsoleWrite('Redrawn: ' & $sTitle & @CRLF)
					EndIf
				Case Else
					If BitAND($wParam, $HSHELL_WINDOWACTIVATED) = $HSHELL_WINDOWACTIVATED And IsString($sTitle) Then
						ConsoleWrite('Activated: ' & $sTitle & @CRLF)
					EndIf
			EndSwitch
	EndSwitch
EndFunc   ;==>WM_SHELLHOOK

Func OnAutoItExit()
	_WinAPI_DeregisterShellHookWindow($g_hForm)
EndFunc   ;==>OnAutoItExit
