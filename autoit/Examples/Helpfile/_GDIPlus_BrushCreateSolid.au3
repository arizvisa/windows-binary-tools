#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hBrush1, $hBrush2

	; Create GUI
	GUICreate("GDI+", 400, 300)
	$g_idMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Create brushes
	_GDIPlus_Startup()
	$hBrush1 = _GDIPlus_BrushCreateSolid()
	$hBrush2 = _GDIPlus_BrushClone($hBrush1)

	; Show brush information
	MemoWrite("Brush 1 handle : 0x" & Hex($hBrush1))
	MemoWrite("Brush 1 type ..: " & _GDIPlus_BrushGetType($hBrush1))
	MemoWrite("Brush 2 handle : 0x" & Hex($hBrush2))
	MemoWrite("Brush 2 type ..: " & _GDIPlus_BrushGetType($hBrush2))

	; Clean up resources
	_GDIPlus_BrushDispose($hBrush2)
	_GDIPlus_BrushDispose($hBrush1)
	_GDIPlus_Shutdown()

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage = '')
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
