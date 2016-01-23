#include <GUIConstantsEx.au3>
#include <GuiToolbar.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hGUI, $hToolbar, $aMetrics
	Local Enum $e_idNew = 1000, $e_idOpen, $e_idSave, $idHelp

	; Create GUI
	$hGUI = GUICreate("Toolbar", 400, 300)
	$hToolbar = _GUICtrlToolbar_Create($hGUI)
	$g_idMemo = GUICtrlCreateEdit("", 2, 36, 396, 262, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 10, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

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

	MemoWrite("Before _GUICtrlToolbar_SetMetrics")

	Sleep(3000)
	GUISetState(@SW_LOCK)
	; Set control metrics
	MemoWrite("Step 1:")
	MemoWrite("$iXPad = 10")
	_GUICtrlToolbar_SetMetrics($hToolbar, 10, 0, 0, 0)
	GUISetState(@SW_UNLOCK)
	MemoWrite("==> No effect")

	Sleep(3000)
	GUISetState(@SW_LOCK)
	; Set control metrics
	MemoWrite("Step 2:")
	MemoWrite("$iYPad = 10")
	_GUICtrlToolbar_SetMetrics($hToolbar, 0, 10, 0, 0)
	GUISetState(@SW_UNLOCK)
	MemoWrite("==> No effect")

	Sleep(3000)
	GUISetState(@SW_LOCK)
	; Set control metrics
	MemoWrite("Step 3:")
	MemoWrite("$iXSpacing = 10")
	_GUICtrlToolbar_SetMetrics($hToolbar, 0, 0, 10, 0)
	GUISetState(@SW_UNLOCK)
	MemoWrite("==> buttons are spaced")

	Sleep(3000)
	GUISetState(@SW_LOCK)
	; Set control metrics
	MemoWrite("Step 4:")
	MemoWrite("$iYSpacing = 10")
	_GUICtrlToolbar_SetMetrics($hToolbar, 0, 0, 0, 10)
	GUISetState(@SW_UNLOCK)
	MemoWrite("==> No effect has only one line of buttons")

	Sleep(3000)
	GUISetState(@SW_LOCK)
	; Set control metrics
	MemoWrite("")
	MemoWrite("Step 5:")
	MemoWrite("$iXPad = 10")
	MemoWrite("$iYPad = 10")
	MemoWrite("$iXSpacing = 10")
	MemoWrite("$iYSpacing = 10")
	_GUICtrlToolbar_SetMetrics($hToolbar, 10, 10, 10, 10)
	GUISetState(@SW_UNLOCK)
	MemoWrite("==> Spaced just because $iXpacing is not 0")

	; Show control metrics
	$aMetrics = _GUICtrlToolbar_GetMetrics($hToolbar)
	MemoWrite("Button padding width ...: " & $aMetrics[0])
	MemoWrite("Button padding height ..: " & $aMetrics[1])
	MemoWrite("Button spacing width ...: " & $aMetrics[2])
	MemoWrite("Button spacing height ..: " & $aMetrics[3])

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Write message to memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
