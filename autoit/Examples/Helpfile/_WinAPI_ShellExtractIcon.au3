#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPI.au3>
#include <WinAPIShellEx.au3>

Local $iIndex = 0, $iTotal = _WinAPI_ExtractIconEx(@SystemDir & '\shell32.dll', -1, 0, 0, 0)

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 160, 160)
Local $idButton = GUICtrlCreateButton('Next', 50, 130, 70, 23)
Local $idIcon = GUICtrlCreateIcon(@SystemDir & '\shell32.dll', 0, 69, 54, 32, 32)
Local $hIcon = GUICtrlGetHandle(-1)
GUISetState(@SW_SHOW)

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $idButton
			$iIndex += 1
			If $iIndex > $iTotal - 1 Then
				$iIndex = 0
			EndIf
			_WinAPI_DestroyIcon(_SendMessage($hIcon, $STM_SETIMAGE, 1, _WinAPI_ShellExtractIcon(@SystemDir & '\shell32.dll', $iIndex, 32, 32)))
	EndSwitch
WEnd
