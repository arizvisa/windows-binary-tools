#include <GUIConstantsEx.au3>
#include <GuiToolbar.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $hGUI, $hToolbar
	Local Enum $e_idNew = 1000, $e_idOpen, $e_idSave, $idHelp

	; Create GUI
	$hGUI = GUICreate("Toolbar", 400, 300)
	$hToolbar = _GUICtrlToolbar_Create($hGUI)
	GUISetState(@SW_SHOW)

	; Add standard system bitmaps
	_GUICtrlToolbar_AddBitmap($hToolbar, 1, -1, $IDB_STD_LARGE_COLOR)

	; Add buttons
	_GUICtrlToolbar_InsertButton($hToolbar, 0, $e_idNew, $STD_FILENEW)
	_GUICtrlToolbar_InsertButton($hToolbar, 1, $e_idOpen, $STD_FILEOPEN)
	_GUICtrlToolbar_InsertButton($hToolbar, 2, $e_idSave, $STD_FILESAVE)
	_GUICtrlToolbar_AddButtonSep($hToolbar)
	_GUICtrlToolbar_InsertButton($hToolbar, 4, $idHelp, $STD_HELP)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example
