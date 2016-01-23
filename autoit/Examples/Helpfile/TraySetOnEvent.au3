#NoTrayIcon
#include <MsgBoxConstants.au3>
#include <TrayConstants.au3> ; Required for the $TRAY_EVENT_PRIMARYDOUBLE, $TRAY_EVENT_SECONDARYUP and $TRAY_ICONSTATE_SHOW constants.

Opt("TrayMenuMode", 3) ; The default tray menu items will not be shown and items are not checked when selected. These are options 1 and 2 for TrayMenuMode.
Opt("TrayOnEventMode", 1) ; Enable TrayOnEventMode.

Example()

Func Example()
	TrayCreateItem("About")

	TrayCreateItem("") ; Create a separator line.

	TrayCreateItem("Exit")
	TrayItemSetOnEvent(-1, "ExitScript")

	TraySetOnEvent($TRAY_EVENT_PRIMARYDOUBLE, "TrayEvent")
	TraySetOnEvent($TRAY_EVENT_SECONDARYUP, "TrayEvent")

	TraySetState($TRAY_ICONSTATE_SHOW) ; Show the tray menu.

	While 1
		Sleep(100) ; An idle loop.
	WEnd
EndFunc   ;==>Example

Func TrayEvent()
	Switch @TRAY_ID ; Check the last tray item identifier.
		Case $TRAY_EVENT_PRIMARYDOUBLE
			; Display a message box about the AutoIt version and installation path of the AutoIt executable.
			MsgBox($MB_SYSTEMMODAL, "", "AutoIt tray menu example." & @CRLF & @CRLF & _
					"Version: " & @AutoItVersion & @CRLF & _
					"Install Path: " & StringLeft(@AutoItExe, StringInStr(@AutoItExe, "\", 0, -1) - 1)) ; Find the folder of a full path.

		Case $TRAY_EVENT_SECONDARYUP
			MsgBox($MB_SYSTEMMODAL, "", "The secondary mouse button was released on the tray icon.")

	EndSwitch
EndFunc   ;==>TrayEvent

Func ExitScript()
	Exit
EndFunc   ;==>ExitScript
