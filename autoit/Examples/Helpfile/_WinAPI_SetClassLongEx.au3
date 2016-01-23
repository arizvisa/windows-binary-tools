#NoTrayIcon

#include <APISysConstants.au3>
#include <GUIConstantsEx.au3>
#include <WinAPISys.au3>
#include <WindowsConstants.au3>

Local $hParent = GUICreate('', 0, 0, 0, 0, 0, $WS_EX_TOOLWINDOW)
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400, -1, -1, BitOR($WS_CAPTION, $WS_POPUP, $WS_SYSMENU), BitOR($WS_EX_DLGMODALFRAME, $WS_EX_TOPMOST), $hParent)

; Remove window icon
_WinAPI_SetClassLongEx($hForm, $GCL_HICONSM, 0)
_WinAPI_SetClassLongEx($hForm, $GCL_HICON, 0)

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
