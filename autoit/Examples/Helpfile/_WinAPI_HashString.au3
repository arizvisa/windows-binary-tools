#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <WinAPIMisc.au3>
#include <WindowsConstants.au3>

Global $g_hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 96)
Global $g_idInput1 = GUICtrlCreateInput('', 20, 20, 360, 20)
GUICtrlSetLimit(-1, 255)
Global $g_idInput2 = GUICtrlCreateInput('', 20, 56, 360, 20, BitOR($GUI_SS_DEFAULT_INPUT, $ES_READONLY))
GUIRegisterMsg($WM_COMMAND, 'WM_COMMAND')
GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $lParam

	Switch $hWnd
		Case $g_hForm
			Switch _WinAPI_LoWord($wParam)
				Case $g_idInput1
					Switch _WinAPI_HiWord($wParam)
						Case $EN_CHANGE
							Local $dHash
							$dHash = _WinAPI_HashString(GUICtrlRead($g_idInput1), False, 16)
							If Not @error Then
								GUICtrlSetData($g_idInput2, $dHash)
							Else
								GUICtrlSetData($g_idInput2, '')
							EndIf
					EndSwitch
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND
