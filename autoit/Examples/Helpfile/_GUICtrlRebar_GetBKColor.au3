#include <GUIConstantsEx.au3>
#include <GuiReBar.au3>
#include <GuiToolbar.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hGUI, $hReBar, $hToolbar, $idExit, $idInput
	Local Enum $e_idNew = 1000, $e_idOpen, $e_idSave, $idHelp

	$hGUI = GUICreate("Rebar", 400, 396, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU, $WS_MAXIMIZEBOX))

	; Create the rebar control
	$hReBar = _GUICtrlRebar_Create($hGUI, BitOR($CCS_TOP, $WS_BORDER, $RBS_VARHEIGHT, $RBS_AUTOSIZE, $RBS_BANDBORDERS))

	$g_idMemo = GUICtrlCreateEdit("", 2, 100, 396, 250, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 10, 400, 0, "Courier New")

	; Create a toolbar to put in the rebar
	$hToolbar = _GUICtrlToolbar_Create($hGUI, BitOR($TBSTYLE_FLAT, $CCS_NORESIZE, $CCS_NOPARENTALIGN))

	; Add standard system bitmaps
	Switch _GUICtrlToolbar_GetBitmapFlags($hToolbar)
		Case 0
			_GUICtrlToolbar_AddBitmap($hToolbar, 1, -1, $IDB_STD_SMALL_COLOR)
		Case 2
			_GUICtrlToolbar_AddBitmap($hToolbar, 1, -1, $IDB_STD_LARGE_COLOR)
	EndSwitch

	; Add buttons
	_GUICtrlToolbar_AddButton($hToolbar, $e_idNew, $STD_FILENEW)
	_GUICtrlToolbar_AddButton($hToolbar, $e_idOpen, $STD_FILEOPEN)
	_GUICtrlToolbar_AddButton($hToolbar, $e_idSave, $STD_FILESAVE)
	_GUICtrlToolbar_AddButtonSep($hToolbar)
	_GUICtrlToolbar_AddButton($hToolbar, $idHelp, $STD_HELP)

	; Create a input box to put in the rebar
	$idInput = GUICtrlCreateInput("Input control", 0, 0, 120, 20)

	; Add band containing the control
	_GUICtrlRebar_AddBand($hReBar, GUICtrlGetHandle($idInput), 120, 200, "Name:")

	; Add band containing the control to the beginning of rebar
	_GUICtrlRebar_AddToolBarBand($hReBar, $hToolbar, "", 0)

	$idExit = GUICtrlCreateButton("Exit", 150, 360, 100, 25)
	GUICtrlSetState($idExit, $GUI_DEFBUTTON + $GUI_FOCUS)

	GUISetState(@SW_SHOW, $hGUI)

	_GUICtrlRebar_SetBandStyleBreak($hReBar, 1)

	MemoWrite("========== Bar Color ==========")
	MemoWrite("Previous BK Color..: " & _GUICtrlRebar_SetBKColor($hReBar, Int(0x00008B)))
	MemoWrite("BK Color...........: " & _GUICtrlRebar_GetBKColor($hReBar))
	MemoWrite("Previous Text Color: " & _GUICtrlRebar_SetTextColor($hReBar, Int(0xFFFFFF)))
	MemoWrite("Text Color.........: " & _GUICtrlRebar_GetTextColor($hReBar))

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE, $idExit
				Exit
		EndSwitch
	WEnd
EndFunc   ;==>Example

; Write message to memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
