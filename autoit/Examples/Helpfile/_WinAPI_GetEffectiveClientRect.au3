#include <GUIConstantsEx.au3>
#include <GUIStatusBar.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPISys.au3>

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 600, 400)
Local $idMenu = GUICtrlCreateMenu("&File")
Local $idExit = GUICtrlCreateMenuItem("E&xit", $idMenu)
Local $a_vID[2]
$a_vID[0] = _GUICtrlStatusBar_Create($hForm)
$a_vID[1] = GUICtrlCreateListView('', 0, 0, 600, 200, -1, 0)

; Calculate effective client area (excluding Menu, ListView, and StatusBar controls)
Local $tRECT = _WinAPI_GetEffectiveClientRect($hForm, $a_vID)
Local $aPos = _WinAPI_GetPosFromRect($tRECT)
GUICtrlCreateLabel($aPos[2] & 'x' & $aPos[3], $aPos[0], $aPos[1], $aPos[2], $aPos[3], BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetFont(-1, 25, 400, 0, 'Tahoma')
GUICtrlSetBkColor(-1, 0xFFD0D0)

; Show GUI
GUISetState(@SW_SHOW)

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE, $idExit
			ExitLoop
	EndSwitch
WEnd
