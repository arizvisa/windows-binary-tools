#include <APISysConstants.au3>
#include <GUIMenu.au3>
#include <WinAPIProc.au3>
#include <WinAPISys.au3>
#include <WindowsConstants.au3>

Local $hEventProc = DllCallbackRegister('_EventProc', 'none', 'ptr;dword;hwnd;long;long;dword;dword')
Global $g_tRECT, $g_iIndex, $g_hMenu = 0

OnAutoItExitRegister('OnAutoItExit')

Local $hEventHook = _WinAPI_SetWinEventHook($EVENT_SYSTEM_MENUPOPUPSTART, $EVENT_SYSTEM_MENUPOPUPEND, DllCallbackGetPtr($hEventProc))

Run(@SystemDir & '\notepad.exe')

While 1
	Sleep(1000)
WEnd

Func OnAutoItExit()
	_WinAPI_UnhookWinEvent($hEventHook)
	DllCallbackFree($hEventProc)
EndFunc   ;==>OnAutoItExit

Func _EventProc($hEventHook, $iEvent, $hWnd, $iObjectID, $iChildID, $iThreadId, $iEventTime)
	#forceref $hEventHook, $iObjectID, $iChildID, $iThreadId, $iEventTime

	Switch $iEvent
		Case $EVENT_SYSTEM_MENUPOPUPSTART
			; Add "View - Calculator"
			$g_hMenu = _SendMessage($hWnd, $MN_GETHMENU)
			If (_GUICtrlMenu_IsMenu($g_hMenu)) And (StringInStr(_GUICtrlMenu_GetItemText($g_hMenu, 0), 'Status Bar')) And (StringInStr(_WinAPI_GetWindowFileName($hWnd), 'notepad.exe')) Then
				$g_iIndex = _GUICtrlMenu_GetItemCount($g_hMenu)
				_GUICtrlMenu_InsertMenuItem($g_hMenu, $g_iIndex, 'Calculator' & @TAB & ':-)')
				$g_tRECT = _GUICtrlMenu_GetItemRectEx($hWnd, $g_hMenu, $g_iIndex)
			Else
				$g_hMenu = 0
			EndIf
		Case $EVENT_SYSTEM_MENUPOPUPEND
			If $g_hMenu Then
				_GUICtrlMenu_DeleteMenu($g_hMenu, $g_iIndex)
				Local $tPOINT = _WinAPI_GetMousePos()
				If _WinAPI_PtInRect($g_tRECT, $tPOINT) Then
					Run(@SystemDir & '\calc.exe')
				EndIf
				$g_hMenu = 0
			EndIf
	EndSwitch
EndFunc   ;==>_EventProc
