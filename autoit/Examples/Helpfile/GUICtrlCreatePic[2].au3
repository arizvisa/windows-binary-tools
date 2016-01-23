#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $g_hGui, $g_aGuiPos, $g_hPic, $g_aPicPos

Example()

Func Example()
	$g_hGui = GUICreate("test transparentpic", 200, 100)
	$g_hPic = GUICreate("", 68, 71, 10, 20, $WS_POPUp, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $g_hGui)
	GUICtrlCreatePic("..\GUI\merlin.gif", 0, 0, 0, 0)

	GUISetState(@SW_SHOW, $g_hPic)
	GUISetState(@SW_SHOW, $g_hGui)

	HotKeySet("{ESC}", "Main")
	HotKeySet("{Left}", "Left")
	HotKeySet("{Right}", "Right")
	HotKeySet("{Down}", "Down")
	HotKeySet("{Up}", "Up")
	$g_aPicPos = WinGetPos($g_hPic)
	$g_aGuiPos = WinGetPos($g_hGui)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd

	HotKeySet("{ESC}")
	HotKeySet("{Left}")
	HotKeySet("{Right}")
	HotKeySet("{Down}")
	HotKeySet("{Up}")
EndFunc   ;==>Example

Func Main()
	$g_aGuiPos = WinGetPos($g_hGui)
	WinMove($g_hGui, "", $g_aGuiPos[0] + 10, $g_aGuiPos[1] + 10)
EndFunc   ;==>Main

Func Left()
	$g_aPicPos = WinGetPos($g_hPic)
	WinMove($g_hPic, "", $g_aPicPos[0] - 10, $g_aPicPos[1])
EndFunc   ;==>Left

Func Right()
	$g_aPicPos = WinGetPos($g_hPic)
	WinMove($g_hPic, "", $g_aPicPos[0] + 10, $g_aPicPos[1])
EndFunc   ;==>Right

Func Down()
	$g_aPicPos = WinGetPos($g_hPic)
	WinMove($g_hPic, "", $g_aPicPos[0], $g_aPicPos[1] + 10)
EndFunc   ;==>Down

Func Up()
	$g_aPicPos = WinGetPos($g_hPic)
	WinMove($g_hPic, "", $g_aPicPos[0], $g_aPicPos[1] - 10)
EndFunc   ;==>Up
