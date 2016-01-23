#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hGUI, $iI, $hStatus
	Local $aParts[3] = [75, 150, -1]

	; Create GUI
	$hGUI = GUICreate("StatusBar Get Text LengthEx", 400, 300)
	$hStatus = _GUICtrlStatusBar_Create($hGUI, $SBT_NOBORDERS)

	; Create memo control
	$g_idMemo = GUICtrlCreateEdit("", 2, 2, 396, 274, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Set parts
	_GUICtrlStatusBar_SetParts($hStatus, $aParts)
	_GUICtrlStatusBar_SetText($hStatus, "Part 1", 0, $SBT_POPOUT)
	_GUICtrlStatusBar_SetText($hStatus, "Part 2", 1, $SBT_NOBORDERS)
	_GUICtrlStatusBar_SetText($hStatus, "Part 3", 2, $SBT_NOTABPARSING)

	; Get text information
	For $iI = 0 To _GUICtrlStatusBar_GetCount($hStatus) - 1
		MemoWrite("Part " & $iI & " text flags .: " & _GUICtrlStatusBar_GetTextFlags($hStatus, $iI))
		MemoWrite("Part " & $iI & " text length : " & _GUICtrlStatusBar_GetTextLength($hStatus, $iI))
		MemoWrite("Part " & $iI & " text length : 0x" & Hex(_GUICtrlStatusBar_GetTextLengthEx($hStatus, $iI)))
		MemoWrite()
	Next

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

; Write message to memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
