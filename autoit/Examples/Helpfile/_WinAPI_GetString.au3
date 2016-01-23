#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <WinAPIMisc.au3>
#include <WinAPISys.au3>

Global Const $WM_MYMESSAGE = _WinAPI_RegisterWindowMessage('MyMessage')

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 93)
Local $idInput = GUICtrlCreateInput('', 20, 20, 360, 20)
Local $idButton = GUICtrlCreateButton('Send', 165, 59, 70, 23)
GUIRegisterMsg($WM_MYMESSAGE, 'WM_MYMESSAGE')
GUISetState(@SW_SHOW)

Local $pString
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $idButton
			$pString = _WinAPI_CreateString(GUICtrlRead($idInput))
			_WinAPI_SetMessageExtraInfo($pString)
			_SendMessage($hForm, $WM_MYMESSAGE, 1, 255)
			_WinAPI_FreeMemory($pString)
	EndSwitch
WEnd

Func WM_MYMESSAGE($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg

	Local $pString = _WinAPI_GetMessageExtraInfo()

	If _WinAPI_IsMemory($pString) Then
		ConsoleWrite('WM_MYMESSAGE | WP = ' & Number($wParam) & ' | LP = ' & Number($lParam) & ' | EXTRA = "' & _WinAPI_GetString($pString) & '"' & @CRLF)
	EndIf
EndFunc   ;==>WM_MYMESSAGE
