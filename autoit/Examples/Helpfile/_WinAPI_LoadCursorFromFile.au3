#include <GUIConstantsEx.au3>
#include <WinAPIRes.au3>
#include <WindowsConstants.au3>

Global $g_hCursor = _WinAPI_LoadCursorFromFile(@ScriptDir & '\Extras\Lens.cur')

OnAutoItExitRegister('OnAutoItExit')

Global $g_hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400)
Global $g_idLabel = GUICtrlCreateLabel('', 100, 100, 200, 200)
GUICtrlSetBkColor(-1, 0xD3D8EF)
GUICtrlSetState(-1, $GUI_DISABLE)
GUIRegisterMsg($WM_SETCURSOR, 'WM_SETCURSOR')
GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func WM_SETCURSOR($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam, $lParam

	Switch $hWnd
		Case $g_hForm

			Local $aCursor = GUIGetCursorInfo($g_hForm)

			If (Not @error) And ($aCursor[4] = $g_idLabel) Then
				_WinAPI_SetCursor($g_hCursor)
				Return 0
			EndIf
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SETCURSOR

Func OnAutoItExit()
	_WinAPI_DestroyCursor($g_hCursor)
EndFunc   ;==>OnAutoItExit
