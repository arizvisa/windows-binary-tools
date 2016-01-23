#include <GUIConstantsEx.au3>
#include <GuiScrollBars.au3>
#include <StructureConstants.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hGUIMsg, $hGUI, $tSCROLLINFO = DllStructCreate($tagSCROLLINFO)

	$hGUI = GUICreate("ScrollBar Example", 400, 400, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU, $WS_SIZEBOX))
	$g_idMemo = GUICtrlCreateEdit("", 2, 2, 380, 360, BitOR($WS_HSCROLL, $WS_VSCROLL))
	GUICtrlSetResizing($g_idMemo, $GUI_DOCKALL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetBkColor(0x88AABB)

	GUISetState(@SW_SHOW)

	_GUIScrollBars_Init($hGUI)

	DllStructSetData($tSCROLLINFO, "cbSize", DllStructGetSize($tSCROLLINFO))
	DllStructSetData($tSCROLLINFO, "fMask", $SIF_ALL)
	_GUIScrollBars_GetScrollInfo($hGUI, $SB_HORZ, $tSCROLLINFO)
	MemoWrite("Horizontal" & @CRLF & "--------------------------------------")
	MemoWrite("nPage....: " & DllStructGetData($tSCROLLINFO, "nPage"))
	MemoWrite("nPos.....: " & DllStructGetData($tSCROLLINFO, "nPos"))
	MemoWrite("nMin.....: " & DllStructGetData($tSCROLLINFO, "nMin"))
	MemoWrite("nMax.....: " & DllStructGetData($tSCROLLINFO, "nMax"))
	MemoWrite("nTrackPos: " & DllStructGetData($tSCROLLINFO, "nTrackPos"))

	DllStructSetData($tSCROLLINFO, "cbSize", DllStructGetSize($tSCROLLINFO))
	DllStructSetData($tSCROLLINFO, "fMask", $SIF_ALL)
	_GUIScrollBars_GetScrollInfo($hGUI, $SB_VERT, $tSCROLLINFO)
	$tSCROLLINFO = _GUIScrollBars_GetScrollInfoEx($hGUI, $SB_VERT)
	MemoWrite(@CRLF & "Vertical" & @CRLF & "--------------------------------------")
	MemoWrite("nPage....: " & DllStructGetData($tSCROLLINFO, "nPage"))
	MemoWrite("nPos.....: " & DllStructGetData($tSCROLLINFO, "nPos"))
	MemoWrite("nMin.....: " & DllStructGetData($tSCROLLINFO, "nMin"))
	MemoWrite("nMax.....: " & DllStructGetData($tSCROLLINFO, "nMax"))
	MemoWrite("nTrackPos: " & DllStructGetData($tSCROLLINFO, "nTrackPos"))

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
