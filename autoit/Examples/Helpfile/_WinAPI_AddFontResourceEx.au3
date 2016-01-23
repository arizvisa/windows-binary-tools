#include <APIGdiConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>

_WinAPI_AddFontResourceEx(@ScriptDir & '\Extras\SF Square Head Bold.ttf', $FR_PRIVATE)

GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 100)
GUICtrlCreateLabel('Simple Text', 10, 25, 380, 50, $SS_CENTER)
GUICtrlSetFont(-1, 38, -1, -1, 'SF Square Head Bold')
GUICtrlSetColor(-1, 0xF06000)
GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
