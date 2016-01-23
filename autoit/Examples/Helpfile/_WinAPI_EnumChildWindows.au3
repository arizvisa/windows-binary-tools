#include <Array.au3>
#include <WinAPISys.au3>

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 310, 360)
GUISetFont(8.5, 400, 0, 'MS Shell Dlg', $hForm)
GUICtrlCreateGroup('Group', 10, 10, 140, 95)
GUICtrlCreateCheckbox('Check1', 22, 26, 120, 23)
GUICtrlCreateCheckbox('Check2', 22, 49, 120, 23)
GUICtrlCreateCheckbox('Check3', 22, 72, 120, 23)
GUICtrlCreateGroup('Group', 160, 10, 140, 95)
GUICtrlCreateRadio('Radio1', 172, 26, 120, 23)
GUICtrlCreateRadio('Radio2', 172, 49, 120, 23)
GUICtrlCreateRadio('Radio3', 172, 72, 120, 23)
GUICtrlCreateButton('OK', 120, 330, 70, 23)
GUICtrlCreateTab(10, 118, 292, 206)
GUICtrlCreateTabItem('Tab1')
GUICtrlCreateTabItem('Tab2')
GUICtrlCreateTabItem('')
GUISetState(@SW_SHOW)

Local $aData = _WinAPI_EnumChildWindows($hForm)

_ArrayDisplay($aData, '_WinAPI_EnumChildWindows')

GUIDelete()
