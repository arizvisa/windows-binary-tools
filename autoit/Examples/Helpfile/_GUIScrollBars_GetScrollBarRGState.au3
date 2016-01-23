#include <GUIConstantsEx.au3>
#include <GuiScrollBars.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hGUIMsg, $hGUI, $aRGState

	$hGUI = GUICreate("ScrollBar Example", 400, 400, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU, $WS_SIZEBOX))
	$g_idMemo = GUICtrlCreateEdit("", 2, 2, 380, 360, BitOR($WS_HSCROLL, $WS_VSCROLL))
	GUICtrlSetResizing($g_idMemo, $GUI_DOCKALL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetBkColor(0x88AABB)

	GUISetState(@SW_SHOW)

	_GUIScrollBars_Init($hGUI)

	$aRGState = _GUIScrollBars_GetScrollBarRGState($hGUI, $OBJID_HSCROLL)
	MemoWrite("Horizontal (Before)" & @CRLF & "--------------------------------------")
	For $x = 0 To 5
		MemoWrite("rgstate[" & $x & "]...: " & $aRGState[$x])
	Next

	MemoWrite(@CRLF & "Disable both arrows: " & _GUIScrollBars_EnableScrollBar($hGUI, $SB_HORZ, $ESB_DISABLE_BOTH) & @CRLF)

	$aRGState = _GUIScrollBars_GetScrollBarRGState($hGUI, $OBJID_HSCROLL)
	MemoWrite("Horizontal (After)" & @CRLF & "--------------------------------------")
	For $x = 0 To 5
		MemoWrite("rgstate[" & $x & "]...: " & $aRGState[$x])
	Next

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
