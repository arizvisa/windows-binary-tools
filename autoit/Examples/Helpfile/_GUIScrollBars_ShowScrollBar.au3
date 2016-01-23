#include <GUIConstantsEx.au3>
#include <GuiScrollBars.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $hGUIMsg, $hGUI

	$hGUI = GUICreate("ScrollBar Example", 400, 400, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU, $WS_SIZEBOX))
	GUISetBkColor(0x88AABB)

	GUISetState(@SW_SHOW)

	_GUIScrollBars_Init($hGUI)

	_GUIScrollBars_ShowScrollBar($hGUI, $SB_HORZ, False)
	Sleep(1000)
	_GUIScrollBars_ShowScrollBar($hGUI, $SB_HORZ)

	Sleep(1000)
	_GUIScrollBars_ShowScrollBar($hGUI, $SB_VERT, False)
	Sleep(1000)
	_GUIScrollBars_ShowScrollBar($hGUI, $SB_VERT)

	While 1
		$hGUIMsg = GUIGetMsg()

		Switch $hGUIMsg
			Case $GUI_EVENT_CLOSE;, $nExititem
				ExitLoop
		EndSwitch
	WEnd

	Exit
EndFunc   ;==>Example
