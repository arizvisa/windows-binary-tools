#NoTrayIcon
#include <TrayConstants.au3> ; Required for the $TRAY_ICONSTATE_SHOW constant.

Example()

Func Example()
	TraySetPauseIcon("shell32.dll", 12) ; Set the pause icon. This will flash on and off when the tray menu is selected and the script is paused.
	TraySetState($TRAY_ICONSTATE_SHOW) ; Show the tray menu.

	While 1
		Sleep(100) ; An idle loop.
	WEnd
EndFunc   ;==>Example
