#include <GUIConstantsEx.au3>
#include <GuiMenu.au3>

Example()

Func Example()
	Local $hGUI, $hFile, $hEdit, $hHelp, $hMain
	Local Enum $e_idNew = 1000, $e_idOpen, $e_idSave, $e_idExit, $e_idCut, $e_idCopy, $e_idPaste, $e_idAbout

	; Create GUI
	$hGUI = GUICreate("Menu", 400, 300)

	; Create File menu
	$hFile = _GUICtrlMenu_CreateMenu()
	_GUICtrlMenu_AddMenuItem($hFile, "&New", $e_idNew)
	_GUICtrlMenu_AddMenuItem($hFile, "&Open", $e_idOpen)
	_GUICtrlMenu_AddMenuItem($hFile, "&Save", $e_idSave)
	_GUICtrlMenu_AddMenuItem($hFile, "", 0)
	_GUICtrlMenu_AddMenuItem($hFile, "E&xit", $e_idExit)

	; Create Edit menu
	$hEdit = _GUICtrlMenu_CreateMenu()
	_GUICtrlMenu_AddMenuItem($hEdit, "&Cut", $e_idCut)
	_GUICtrlMenu_AddMenuItem($hEdit, "C&opy", $e_idCopy)
	_GUICtrlMenu_AddMenuItem($hEdit, "&Paste", $e_idPaste)

	; Create Help menu
	$hHelp = _GUICtrlMenu_CreateMenu()
	_GUICtrlMenu_AddMenuItem($hHelp, "&About", $e_idAbout)

	; Create Main menu
	$hMain = _GUICtrlMenu_CreateMenu()
	_GUICtrlMenu_AddMenuItem($hMain, "&File", 0, $hFile)
	_GUICtrlMenu_AddMenuItem($hMain, "&Edit", 0, $hEdit)
	_GUICtrlMenu_AddMenuItem($hMain, "&Help", 0, $hHelp)

	; Set window menu
	_GUICtrlMenu_SetMenu($hGUI, $hMain)
	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example
