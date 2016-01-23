#include <GUIConstantsEx.au3>
#include <GuiMenu.au3>
#include <WinAPI.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hGUI, $hFile, $hEdit, $hHelp, $hMain, $hBmp1, $hBmp2
	Global Enum $e_idNew = 1000, $e_idOpen, $e_idSave, $e_idExit, $e_idCut, $e_idCopy, $e_idPaste, $e_idAbout

	; Create GUI
	$hGUI = GUICreate("Menu", 400, 300)

	; Create File menu
	$hFile = _GUICtrlMenu_CreateMenu()
	_GUICtrlMenu_InsertMenuItem($hFile, 0, "&New", $e_idNew)
	_GUICtrlMenu_InsertMenuItem($hFile, 1, "&Open", $e_idOpen)
	_GUICtrlMenu_InsertMenuItem($hFile, 2, "&Save", $e_idSave)
	_GUICtrlMenu_InsertMenuItem($hFile, 3, "", 0)
	_GUICtrlMenu_InsertMenuItem($hFile, 4, "E&xit", $e_idExit)

	; Create Edit menu
	$hEdit = _GUICtrlMenu_CreateMenu()
	_GUICtrlMenu_InsertMenuItem($hEdit, 0, "&Cut", $e_idCut)
	_GUICtrlMenu_InsertMenuItem($hEdit, 1, "C&opy", $e_idCopy)
	_GUICtrlMenu_InsertMenuItem($hEdit, 2, "&Paste", $e_idPaste)

	; Create Help menu
	$hHelp = _GUICtrlMenu_CreateMenu()
	_GUICtrlMenu_InsertMenuItem($hHelp, 0, "&About", $e_idAbout)

	; Create Main menu
	$hMain = _GUICtrlMenu_CreateMenu()
	_GUICtrlMenu_InsertMenuItem($hMain, 0, "&File", 0, $hFile)
	_GUICtrlMenu_InsertMenuItem($hMain, 1, "&Edit", 0, $hEdit)
	_GUICtrlMenu_InsertMenuItem($hMain, 2, "&Help", 0, $hHelp)

	; Set window menu
	_GUICtrlMenu_SetMenu($hGUI, $hMain)

	; Create memo control
	$g_idMemo = GUICtrlCreateEdit("", 2, 2, 396, 276, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Set File menu checked/unchecked bitmaps
	$hBmp1 = _WinAPI_CreateSolidBitmap($hGUI, 0xFF0000, 11, 11)
	$hBmp2 = _WinAPI_CreateSolidBitmap($hGUI, 0x00FF00, 11, 11)
	_GUICtrlMenu_SetItemBmpChecked($hFile, 0, $hBmp1)
	_GUICtrlMenu_SetItemBmpChecked($hFile, 1, $hBmp1)
	_GUICtrlMenu_SetItemBmpChecked($hFile, 2, $hBmp1)
	_GUICtrlMenu_SetItemBmpUnchecked($hFile, 0, $hBmp2)
	_GUICtrlMenu_SetItemBmpUnchecked($hFile, 1, $hBmp2)
	_GUICtrlMenu_SetItemBmpUnchecked($hFile, 2, $hBmp2)

	; Check Open menu item
	_GUICtrlMenu_CheckMenuItem($hFile, 1)

	; Show that bitmap handles match
	MemoWrite("Checked handle ......: 0x" & Hex($hBmp1))
	MemoWrite("Unchecked handle ....: 0x" & Hex($hBmp2))
	MemoWrite("Open checked handle .: 0x" & Hex(_GUICtrlMenu_GetItemBmpChecked($hFile, 0)))
	MemoWrite("Open unchecked handle: 0x" & Hex(_GUICtrlMenu_GetItemBmpUnchecked($hFile, 0)))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Write message to memo
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
