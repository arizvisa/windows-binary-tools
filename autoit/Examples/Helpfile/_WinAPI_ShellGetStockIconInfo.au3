#include <APIShellExConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <StaticConstants.au3>
#include <WinAPIShellEx.au3>
#include <WinAPISys.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 200, 236)
GUICtrlCreateIcon('', 0, 36, 36, 128, 128)
Local $h_Icon = GUICtrlGetHandle(-1)
GUICtrlSetState(-1, $GUI_DISABLE)
Local $idLabel = GUICtrlCreateLabel('', 70, 174, 60, 14, $SS_CENTER)
Local $idPrev = GUICtrlCreateButton('<', 32, 200, 60, 24)
Local $idNext = GUICtrlCreateButton('>', 108, 200, 60, 24)
GUISetState(@SW_SHOW)

Local $tSHSTOCKICONINFO, $hIcon, $hOld, $iCount = 0, $bUpdate = True
While 1
	If $bUpdate Then
		GUICtrlSetData($idLabel, 'SIID: ' & $iCount)
		$tSHSTOCKICONINFO = _WinAPI_ShellGetStockIconInfo($iCount, $SHGSI_ICONLOCATION)
		$hIcon = _WinAPI_ShellExtractIcon(DllStructGetData($tSHSTOCKICONINFO, 'Path'), DllStructGetData($tSHSTOCKICONINFO, 'iIcon'), 128, 128)
		$hOld = _SendMessage($h_Icon, $STM_SETIMAGE, 1, $hIcon)
		If $hOld Then
			_WinAPI_DestroyIcon($hOld)
		EndIf
		$bUpdate = 0
	EndIf
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $idPrev
			$iCount -= 1
			If $iCount < 0 Then
				$iCount = $SIID_MAX_ICONS - 1
			EndIf
			$bUpdate = 1
		Case $idNext
			$iCount += 1
			If $iCount > $SIID_MAX_ICONS - 1 Then
				$iCount = 0
			EndIf
			$bUpdate = 1
	EndSwitch
WEnd
