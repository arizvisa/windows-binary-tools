#include <GUIConstantsEx.au3>
#include <WinAPISys.au3>
#include <WindowsConstants.au3>

OnAutoItExitRegister('OnAutoItExit')

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400)
Local $idCheck = GUICtrlCreateCheckbox('Enable Drag && Drop', 10, 370, 120, 19)
Local $idLabel = GUICtrlCreateLabel('', 100, 100, 200, 200)
Global $g_hLabel = GUICtrlGetHandle($idLabel)
GUICtrlSetBkColor(-1, 0xD3D8EF)
GUICtrlCreateLabel('Drop here', 175, 193, 50, 14)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

; Allow WM_DROPFILES to be received from lower privileged processes (Windows Vista or later)
#cs
If IsAdmin() Then
	_WinAPI_ChangeWindowMessageFilterEx($g_hLabel, $WM_COPYGLOBALDATA, $MSGFLT_ALLOW)
	_WinAPI_ChangeWindowMessageFilterEx($g_hLabel, $WM_DROPFILES, $MSGFLT_ALLOW)
EndIf
#ce

; Register label window proc
Global $g_hDll = DllCallbackRegister('_WinProc', 'ptr', 'hwnd;uint;wparam;lparam')
Global $g_pDll = DllCallbackGetPtr($g_hDll)
Global $g_hProc = _WinAPI_SetWindowLong($g_hLabel, $GWL_WNDPROC, $g_pDll)

GUISetState(@SW_SHOW)

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $idCheck
			_WinAPI_DragAcceptFiles($g_hLabel, GUICtrlRead($idCheck) = $GUI_CHECKED)
	EndSwitch
WEnd

Func _WinProc($hWnd, $iMsg, $wParam, $lParam)
	Switch $iMsg
		Case $WM_DROPFILES
			Local $sFileList = _WinAPI_DragQueryFileEx($wParam)
			If Not @error Then
				ConsoleWrite('--------------------------------------------------' & @CRLF)
				For $i = 1 To $sFileList[0]
					ConsoleWrite($sFileList[$i] & @CRLF)
				Next
			EndIf
			_WinAPI_DragFinish($wParam)
			Return 0
	EndSwitch
	Return _WinAPI_CallWindowProc($g_hProc, $hWnd, $iMsg, $wParam, $lParam)
EndFunc   ;==>_WinProc

Func OnAutoItExit()
	_WinAPI_SetWindowLong($g_hLabel, $GWL_WNDPROC, $g_hProc)
	DllCallbackFree($g_hDll)
EndFunc   ;==>OnAutoItExit
