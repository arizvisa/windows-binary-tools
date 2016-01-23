#include <GUIConstantsEx.au3>
#include <GuiToolbar.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $hGUI, $hToolbar, $bStyle
	Local Enum $e_idNew = 1000, $e_idOpen, $e_idSave, $idHelp

	; Create GUI
	$hGUI = GUICreate("Toolbar", 400, 300)
	$hToolbar = _GUICtrlToolbar_Create($hGUI)
	GUISetBkColor(0xffffff)
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

	; Change control style
	$bStyle = _GUICtrlToolbar_GetStyleTransparent($hToolbar)
	MsgBox($MB_SYSTEMMODAL, "Information", "Toolbar has transparent style .: " & $bStyle)
	GUISetState(@SW_LOCK)
	_GUICtrlToolbar_SetStyleTransparent($hToolbar, Not $bStyle)
	GUISetState(@SW_UNLOCK)
	MsgBox($MB_SYSTEMMODAL, "Information", "Toolbar has transparent style .: " & _GUICtrlToolbar_GetStyleTransparent($hToolbar))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example
