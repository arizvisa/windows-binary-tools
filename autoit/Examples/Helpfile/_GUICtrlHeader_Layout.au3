#include <GUIConstantsEx.au3>
#include <GuiHeader.au3>
#include <WinAPI.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hGUI, $hHeader, $tRECT, $tPos

	; Create GUI
	$hGUI = GUICreate("Header", 400, 300)
	$hHeader = _GUICtrlHeader_Create($hGUI)
	_GUICtrlHeader_SetUnicodeFormat($hHeader, True)
	$g_idMemo = GUICtrlCreateEdit("", 2, 24, 396, 274, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Add columns
	_GUICtrlHeader_AddItem($hHeader, "Column 1", 100)
	_GUICtrlHeader_AddItem($hHeader, "Column 2", 100)
	_GUICtrlHeader_AddItem($hHeader, "Column 3", 100)
	_GUICtrlHeader_AddItem($hHeader, "Column 4", 100)

	; Get header layout
	$tRECT = _WinAPI_GetClientRect($hGUI)
	$tPos = _GUICtrlHeader_Layout($hHeader, $tRECT)

	; Show header layout
	MemoWrite("Window handle .....: " & DllStructGetData($tPos, "hWnd"))
	MemoWrite("Z order handle ....: " & DllStructGetData($tPos, "InsertAfter"))
	MemoWrite("Horizontal position: " & DllStructGetData($tPos, "X"))
	MemoWrite("Vertical position .: " & DllStructGetData($tPos, "Y"))
	MemoWrite("Width .............: " & DllStructGetData($tPos, "CX"))
	MemoWrite("Height ............: " & DllStructGetData($tPos, "CY"))
	MemoWrite("Flags .............: " & DllStructGetData($tPos, "Flags"))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
