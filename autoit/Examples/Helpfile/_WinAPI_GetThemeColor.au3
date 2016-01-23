#include <APIThemeConstants.au3>
#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <WinAPITheme.au3>
#include <WindowsConstants.au3>

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400)
GUISetFont(8.5, 400, 0, 'MS Shell Dlg', $hForm)
Local $idButton = GUICtrlCreateButton('Set Theme Color', 140, 368, 115, 23)
GUICtrlCreateTab(7, 7, 388, 354)
GUICtrlCreateTabItem('About')
Local $idSlider = GUICtrlCreateSlider(20, 45, 360, 26)
GUICtrlCreateTabItem('')
GUISetState(@SW_SHOW)

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $idButton
			GUICtrlSetBkColor($idSlider, _GetTabBodyColor($hForm))
			GUICtrlSetState($idButton, $GUI_DISABLE)
	EndSwitch
WEnd

Func _GetTabBodyColor($hForm)
	Local $iDefault = _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_3DFACE))

	Local $hTheme = _WinAPI_OpenThemeData($hForm, 'TAB')
	If @error Then
		Return $iDefault
	EndIf
	Local $iPart
	Switch @OSVersion
		Case 'WIN_XP', 'WIN_2003'
			$iPart = 10 ; TABP_BODY
		Case Else
			$iPart = 11 ; TABP_AEROWIZARDBODY
	EndSwitch
	Local $iColor = _WinAPI_GetThemeColor($hTheme, $iPart, 1, $TMT_FILLCOLORHINT)
	_WinAPI_CloseThemeData($hTheme)
	If $iColor < 0 Then
		Return $iDefault
	EndIf
	Return $iColor
EndFunc   ;==>_GetTabBodyColor
