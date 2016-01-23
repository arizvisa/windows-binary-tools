#include <APILocaleConstants.au3>
#include <APISysConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPILocale.au3>
#include <WinAPISys.au3>

GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 300, 200)
Local $idLabel = GUICtrlCreateLabel('', 10, 66, 280, 40, $SS_CENTER)
GUICtrlSetFont(-1, 12, 800, 0, 'Tahoma')
Local $idPrev = GUICtrlCreateButton('<', 82, 164, 60, 24)
Local $idNext = GUICtrlCreateButton('>', 158, 164, 60, 24)
GUISetState(@SW_SHOW)

Local $iUpdate = 1
While 1
	If $iUpdate Then
		GUICtrlSetData($idLabel, '0x' & StringRight(@KBLayout, 4) & @CRLF & _WinAPI_GetLocaleInfo(Number('0x' & @KBLayout), $LOCALE_SLANGUAGE))
		$iUpdate = 0
	EndIf

	Switch GUIGetMsg()
		Case -3
			ExitLoop
		Case $idNext
			_WinAPI_ActivateKeyboardLayout($HKL_NEXT)
			$iUpdate = 1
		Case $idPrev
			_WinAPI_ActivateKeyboardLayout($HKL_PREV)
			$iUpdate = 1
	EndSwitch
WEnd
