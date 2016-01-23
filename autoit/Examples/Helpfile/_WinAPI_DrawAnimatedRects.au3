#NoTrayIcon

#include <APIGdiConstants.au3>
#include <APISysConstants.au3>
#include <GUIConstantsEx.au3>
#include <MenuConstants.au3>
#include <TrayConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPISys.au3>
#include <WIndowsConstants.au3>

Opt('TrayMenuMode', 1)

Local $hTray = ControlGetHandle('[CLASS:Shell_TrayWnd]', '', 'TrayNotifyWnd1')

Local $idTrayRestoreItem = TrayCreateItem('Restore')
TrayItemSetState(-1, $TRAY_DEFAULT)
TrayCreateItem('')
Local $idTrayExitItem = TrayCreateItem('Exit')
TraySetClick(8)

Global $g_hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'))
Global $g_idDummy = GUICtrlCreateDummy()
GUIRegisterMsg($WM_SYSCOMMAND, 'WM_SYSCOMMAND')
GUISetState(@SW_SHOW)

While 1
	Switch TrayGetMsg()
		Case $idTrayRestoreItem
			_WinAPI_DrawAnimatedRects($g_hForm, _WinAPI_GetWindowRect($hTray), _WinAPI_GetWindowRect($g_hForm))
			GUISetState(@SW_SHOW, $g_hForm)
			TraySetState(2)
		Case $idTrayExitItem
			ExitLoop
	EndSwitch
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			_WinAPI_AnimateWindow($g_hForm, BitOR($AW_BLEND, $AW_HIDE))
			ExitLoop
		Case $g_idDummy ; Minimize
			_WinAPI_DrawAnimatedRects($g_hForm, _WinAPI_GetWindowRect($g_hForm), _WinAPI_GetWindowRect($hTray))
			GUISetState(@SW_HIDE, $g_hForm)
			TraySetState(1)
	EndSwitch
WEnd

Func WM_SYSCOMMAND($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $lParam

	Switch $hWnd
		Case $g_hForm
			Switch $wParam
				Case $SC_MINIMIZE
					GUICtrlSendToDummy($g_idDummy)
					Return 0
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SYSCOMMAND
