#include <GuiComboBoxEx.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI, $tRECT, $hCombo

	; Create GUI
	$hGUI = GUICreate("ComboBoxEx Get Dropped Control RectEx", 400, 300)
	$hCombo = _GUICtrlComboBoxEx_Create($hGUI, "", 2, 2, 394, 100)
	GUISetState(@SW_SHOW)

	; Add files
	_GUICtrlComboBoxEx_BeginUpdate($hCombo)
	_GUICtrlComboBoxEx_AddDir($hCombo, "", $DDL_DRIVES, False)
	_GUICtrlComboBoxEx_AddDir($hCombo, "", $DDL_DRIVES)
	_GUICtrlComboBoxEx_BeginUpdate($hCombo)
	_GUICtrlComboBoxEx_AddDir($hCombo, @WindowsDir & "\*.exe")
	_GUICtrlComboBoxEx_EndUpdate($hCombo)
	_GUICtrlComboBoxEx_EndUpdate($hCombo)

	; Get Dropped Control Rect
	$tRECT = _GUICtrlComboBoxEx_GetDroppedControlRectEx($hCombo)
	MsgBox($MB_SYSTEMMODAL, "Information", "Dropped Control Rect: " & _
			StringFormat("[%d][%d][%d][%d]", DllStructGetData($tRECT, "Left"), DllStructGetData($tRECT, "Top"), _
			DllStructGetData($tRECT, "Right"), DllStructGetData($tRECT, "Bottom")))

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example
