#include <GUIConstantsEx.au3>
#include <GuiMenu.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $g_idMemo
Global Enum $e_idNew = 1000, $e_idOpen, $e_idSave, $e_idExit, $e_idCut, $e_idCopy, $e_idPaste, $e_idAbout

Example()

Func Example()
	Local $hGUI, $hFile, $hEdit, $hHelp, $hMain

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

	; Loop until the user exits.
	GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Handle menu commands
Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $lParam
	Switch _WinAPI_LoWord($wParam)
		Case $e_idNew
			MemoWrite("New")
		Case $e_idOpen
			MemoWrite("Open")
		Case $e_idSave
			MemoWrite("Save")
		Case $e_idExit
			Exit
		Case $e_idCut
			MemoWrite("Cut")
		Case $e_idCopy
			MemoWrite("Copy")
		Case $e_idPaste
			MemoWrite("Paste")
		Case $e_idAbout
			MemoWrite("About")
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND

; Write message to memo
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
