#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Local $hParent = WinGetHandle('[CLASS:Progman;TITLE:Program Manager]')

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400, 100, 100, -1, $WS_EX_TOOLWINDOW)

; Attach window to the desktop (always on bottom)
_WinAPI_SetParent($hForm, $hParent)

GUISetState(@SW_SHOWNOACTIVATE)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
