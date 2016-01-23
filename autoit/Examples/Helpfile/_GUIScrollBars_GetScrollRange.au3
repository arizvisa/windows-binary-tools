#include <GUIConstantsEx.au3>
#include <GuiScrollBars.au3>
#include <StructureConstants.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hGUIMsg, $hGUI, $aRangeMinMax

	$hGUI = GUICreate("ScrollBar Example", 400, 400, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU, $WS_SIZEBOX))
	$g_idMemo = GUICtrlCreateEdit("", 2, 2, 380, 380, BitOR($WS_HSCROLL, $WS_VSCROLL))
	GUICtrlSetResizing($g_idMemo, $GUI_DOCKALL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetBkColor(0x88AABB)

	GUISetState(@SW_SHOW)

	_GUIScrollBars_Init($hGUI)

	$aRangeMinMax = _GUIScrollBars_GetScrollRange($hGUI, $SB_VERT)
	MemoWrite("Vertical Min/Max: " & $aRangeMinMax[0] & "/" & $aRangeMinMax[1])
	$aRangeMinMax = _GUIScrollBars_GetScrollRange($hGUI, $SB_HORZ)
	MemoWrite("Horizontal Min/Max: " & $aRangeMinMax[0] & "/" & $aRangeMinMax[1])
	Sleep(1000)
	_GUIScrollBars_SetScrollRange($hGUI, $SB_VERT, 3, 30)
	$aRangeMinMax = _GUIScrollBars_GetScrollRange($hGUI, $SB_VERT)
	MemoWrite("New Vertical Min/Max: " & $aRangeMinMax[0] & "/" & $aRangeMinMax[1])
	Sleep(1000)
	_GUIScrollBars_SetScrollRange($hGUI, $SB_HORZ, 10, 98)
	$aRangeMinMax = _GUIScrollBars_GetScrollRange($hGUI, $SB_HORZ)
	MemoWrite("New Horizontal Min/Max: " & $aRangeMinMax[0] & "/" & $aRangeMinMax[1])

	While 1
		$hGUIMsg = GUIGetMsg()

		Switch $hGUIMsg
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	Exit
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
