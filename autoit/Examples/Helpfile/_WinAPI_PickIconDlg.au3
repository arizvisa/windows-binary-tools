#include <GUIConstantsEx.au3>
#include <WinAPIDlg.au3>

Local $aLast[2] = [@SystemDir & '\shell32.dll', 3]

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 160, 160)
Local $idButton = GUICtrlCreateButton('Change Icon...', 25, 130, 110, 23)
Local $idIcon = GUICtrlCreateIcon($aLast[0], -(1 + $aLast[1]), 64, 54, 32, 32)
GUISetState(@SW_SHOW)

Local $aData
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $idButton
			$aData = _WinAPI_PickIconDlg($aLast[0], $aLast[1], $hForm)
			If IsArray($aData) Then
				GUICtrlSetImage($idIcon, $aData[0], -(1 + $aData[1]))
				$aLast = $aData
			EndIf
	EndSwitch
WEnd
