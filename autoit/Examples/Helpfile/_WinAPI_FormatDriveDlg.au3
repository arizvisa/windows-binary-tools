#include <Array.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <WinAPIDlg.au3>

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 200, 100)
Local $vDrive = DriveGetDrive('ALL')
$vDrive = StringUpper(_ArrayToString($vDrive, '|', 1))
GUICtrlCreateLabel('Select drive:', 15, 29, 62, 14)
Local $idCombo = GUICtrlCreateCombo('', 79, 25, 40, 21, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, $vDrive, StringLeft($vDrive, 2))
Local $idButton = GUICtrlCreateButton('Format...', 65, 70, 70, 23)
GUISetState(@SW_SHOW)

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $idButton
			_WinAPI_FormatDriveDlg(GUICtrlRead($idCombo), 0, $hForm)
	EndSwitch
WEnd
