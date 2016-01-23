#include <GUIConstantsEx.au3>
#include <GuiScrollBars.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hGUIMsg, $hGUI

	$hGUI = GUICreate("ScrollBar Example", 400, 400, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU, $WS_SIZEBOX))
	$g_idMemo = GUICtrlCreateEdit("", 2, 32, 380, 226, BitOR($WS_HSCROLL, $WS_VSCROLL))
	GUICtrlSetResizing($g_idMemo, $GUI_DOCKALL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetBkColor(0x88AABB)

	GUISetState(@SW_SHOW)

	_GUIScrollBars_Init($hGUI)

	MemoWrite("Disable down arrow: " & _GUIScrollBars_EnableScrollBar($hGUI, $SB_VERT, $ESB_DISABLE_DOWN))
	Sleep(3000)
	MemoWrite("Disable up arrow: " & _GUIScrollBars_EnableScrollBar($hGUI, $SB_VERT, $ESB_DISABLE_UP))
	Sleep(3000)
	MemoWrite("Enable both arrows: " & _GUIScrollBars_EnableScrollBar($hGUI, $SB_VERT, $ESB_ENABLE_BOTH))
	Sleep(3000)
	MemoWrite("Disable left arrow: " & _GUIScrollBars_EnableScrollBar($hGUI, $SB_HORZ, $ESB_DISABLE_LEFT))
	Sleep(3000)
	MemoWrite("Disable right arrow: " & _GUIScrollBars_EnableScrollBar($hGUI, $SB_HORZ, $ESB_DISABLE_RIGHT))
	Sleep(3000)
	MemoWrite("Enable both arrows: " & _GUIScrollBars_EnableScrollBar($hGUI, $SB_HORZ, $ESB_ENABLE_BOTH))

	While 1
		$hGUIMsg = GUIGetMsg()

		Switch $hGUIMsg
			Case $GUI_EVENT_CLOSE;, $nExititem
				ExitLoop
		EndSwitch
	WEnd

	Exit
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
