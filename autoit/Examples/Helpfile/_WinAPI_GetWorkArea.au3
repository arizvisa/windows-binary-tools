#include <GUIConstantsEx.au3>
#include <WinAPISys.au3>
#include <WindowsConstants.au3>

Local $tRECT = _WinAPI_GetWorkArea()
Local $iWidth = DllStructGetData($tRECT, 'Right') - DllStructGetData($tRECT, 'Left')
Local $iHeight = DllStructGetData($tRECT, 'Bottom') - DllStructGetData($tRECT, 'Top')
Local $X = DllStructGetData($tRECT, 'Left')
Local $Y = DllStructGetData($tRECT, 'Top')

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), $iWidth, $iHeight, $X, $Y, $WS_POPUP, $WS_EX_TOPMOST)
GUISetBkColor(0, $hForm)
WinSetTrans($hForm, '', 128)
GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
