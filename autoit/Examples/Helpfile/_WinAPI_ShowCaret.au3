#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WinAPIRes.au3>
#include <WindowsConstants.au3>

Global $g_iDuration = Default, $g_hBitmap = _WinAPI_CreateSolidBitmap(0, 0x00AEFF, 10, 14)

OnAutoItExitRegister('OnAutoItExit')

Global $g_hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 93)
Global $g_idInput = GUICtrlCreateInput('', 20, 20, 360, 20)
Local $idButton = GUICtrlCreateButton('Exit', 165, 59, 70, 23)
GUIRegisterMsg($WM_COMMAND, 'WM_COMMAND')
GUISetState(@SW_SHOW)

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE, $idButton
			ExitLoop
	EndSwitch
WEnd

Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg

	Switch $hWnd
		Case $g_hForm
			Switch _WinAPI_LoWord($wParam)
				Case $g_idInput
					Switch _WinAPI_HiWord($wParam)
						Case $EN_KILLFOCUS
							_WinAPI_HideCaret($lParam)
							_WinAPI_DestroyCaret()
							_WinAPI_SetCaretBlinkTime($g_iDuration)
							$g_iDuration = Default
						Case $EN_SETFOCUS
							$g_iDuration = _WinAPI_SetCaretBlinkTime(-1)
							_WinAPI_CreateCaret($lParam, $g_hBitmap)
							_WinAPI_ShowCaret($lParam)
					EndSwitch
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND

Func OnAutoItExit()
	_WinAPI_DeleteObject($g_hBitmap)
	If Not IsKeyword($g_iDuration) Then
		_WinAPI_SetCaretBlinkTime($g_iDuration)
	EndIf
EndFunc   ;==>OnAutoItExit
