#include <GUIConstantsEx.au3>
#include <WinAPISys.au3>
#include <WindowsConstants.au3>

Local $aWnds[4]

For $i = 0 To UBound($aWnds) - 1
	$aWnds[$i] = GUICreate('#' & ($i + 1), 400, 400, -1, -1, BitOR($WS_CAPTION, $WS_POPUP, $WS_SIZEBOX, $WS_SYSMENU))
	GUISetState(@SW_SHOW)
Next

_WinAPI_TileWindows($aWnds, _WinAPI_CreateRectEx(20, 20, 600, 600))

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
