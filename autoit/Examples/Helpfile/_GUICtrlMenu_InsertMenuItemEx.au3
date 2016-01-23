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
	InsertItem($hFile, 0, "&New", $e_idNew)
	InsertItem($hFile, 1, "&Open", $e_idOpen)
	InsertItem($hFile, 2, "&Save", $e_idSave)
	InsertItem($hFile, 3, "", 0)
	InsertItem($hFile, 4, "E&xit", $e_idExit)

	; Create Edit menu
	$hEdit = _GUICtrlMenu_CreateMenu()
	InsertItem($hEdit, 0, "&Cut", $e_idCut)
	InsertItem($hEdit, 1, "C&opy", $e_idCopy)
	InsertItem($hEdit, 2, "&Paste", $e_idPaste)

	; Create Help menu
	$hHelp = _GUICtrlMenu_CreateMenu()
	InsertItem($hHelp, 0, "&About", $e_idAbout)

	; Create Main menu
	$hMain = _GUICtrlMenu_CreateMenu()
	InsertItem($hMain, 0, "&File", 0, $hFile)
	InsertItem($hMain, 1, "&Edit", 0, $hEdit)
	InsertItem($hMain, 2, "&Help", 0, $hHelp)

	; Set window menu
	_GUICtrlMenu_SetMenu($hGUI, $hMain)
	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Insert menu item (the hard way)
Func InsertItem($hMenu, $iIndex, $sText, $iCmdID = 0, $hSubMenu = 0)
	Local $tMenu, $tText

	$tMenu = DllStructCreate($tagMENUITEMINFO)
	DllStructSetData($tMenu, "Size", DllStructGetSize($tMenu))
	DllStructSetData($tMenu, "Mask", BitOR($MIIM_ID, $MIIM_STRING, $MIIM_SUBMENU))
	DllStructSetData($tMenu, "ID", $iCmdID)
	DllStructSetData($tMenu, "SubMenu", $hSubMenu)
	If $sText = "" Then
		DllStructSetData($tMenu, "Mask", $MIIM_FTYPE)
		DllStructSetData($tMenu, "Type", $MFT_SEPARATOR)
	Else
		DllStructSetData($tMenu, "Mask", BitOR($MIIM_ID, $MIIM_STRING, $MIIM_SUBMENU))
		$tText = DllStructCreate("wchar Text[" & StringLen($sText) + 1 & "]")
		DllStructSetData($tText, "Text", $sText)
		DllStructSetData($tMenu, "TypeData", DllStructGetPtr($tText))
	EndIf
	_GUICtrlMenu_InsertMenuItemEx($hMenu, $iIndex, $tMenu)
EndFunc   ;==>InsertItem
