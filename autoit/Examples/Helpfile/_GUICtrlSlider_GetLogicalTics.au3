#include <GUIConstantsEx.au3>
#include <GuiSlider.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $idSlider, $aTics

	; Create GUI
	GUICreate("Slider Get Logical Tic Positions", 400, 296)
	$idSlider = GUICtrlCreateSlider(2, 2, 300, 20, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS))
	$g_idMemo = GUICtrlCreateEdit("", 2, 32, 396, 266, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	$aTics = _GUICtrlSlider_GetLogicalTics($idSlider)
	MemoWrite("Number Tics Excluding 1st and last .....: " & UBound($aTics))
	For $x = 0 To UBound($aTics) - 1
		MemoWrite(StringFormat("(%02d) Logical Tick Position .............: %d", $x, $aTics[$x]))
	Next

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
