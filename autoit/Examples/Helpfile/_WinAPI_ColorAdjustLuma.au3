#include <GUIConstantsEx.au3>
#include <SliderConstants.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>

Opt('TrayAutoPause', 0)

; Create GUI
Global $g_hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 300, 327)
GUISetBkColor(0x808080)
Global $g_idGraphic = GUICtrlCreateGraphic(0, 0, 150, 300)
GUICtrlSetBkColor(-1, 0x808080)
GUICtrlCreateLabel('', 0, 300, 303, 2, $SS_ETCHEDHORZ)
Global $g_idLabel = GUICtrlCreateLabel('0%', 30, 132, 90, 37, $SS_CENTER)
GUICtrlSetFont(-1, 24, 800, 0, 'Arial')
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0xFFFFFF)
Global $g_idSlider = GUICtrlCreateSlider(0, 302, 300, 25, BitOR($TBS_BOTH, $TBS_NOTICKS))
Global $g_hSlider = GUICtrlGetHandle(-1)
GUICtrlSetLimit(-1, 50, -50)
GUICtrlSetData(-1, 0)

; Register WM_HSCROLL message for live scrolling and show GUI
GUIRegisterMsg($WM_HSCROLL, 'WM_HSCROLL')
GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func WM_HSCROLL($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam

	Local $iPercent
	Switch $hWnd
		Case $g_hForm
			Switch $lParam
				Case $g_hSlider
					$iPercent = GUICtrlRead($g_idSlider)
					GUICtrlSetBkColor($g_idGraphic, _WinAPI_ColorAdjustLuma(0x808080, $iPercent))
					GUICtrlSetData($g_idLabel, $iPercent & '%')
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_HSCROLL
