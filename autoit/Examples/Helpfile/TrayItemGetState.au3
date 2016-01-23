#NoTrayIcon
#include <MsgBoxConstants.au3>
#include <TrayConstants.au3> ; Required for the $TRAY_ICONSTATE_SHOW constant.

Opt("TrayMenuMode", 3) ; The default tray menu items will not be shown and items are not checked when selected. These are options 1 and 2 for TrayMenuMode.

Example()

Func Example()
	Local $idGetState = TrayCreateItem("Get 'About' State")
	TrayCreateItem("") ; Create a separator line.

	Local $idAbout = TrayCreateItem("About")
	TrayCreateItem("") ; Create a separator line.

	Local $idExit = TrayCreateItem("Exit")

	TraySetState($TRAY_ICONSTATE_SHOW) ; Show the tray menu.

	While 1
		Switch TrayGetMsg()
			Case $idAbout ; Display a message box about the AutoIt version and installation path of the AutoIt executable.
				MsgBox($MB_SYSTEMMODAL, "", "AutoIt tray menu example." & @CRLF & @CRLF & _
						"Version: " & @AutoItVersion & @CRLF & _
						"Install Path: " & StringLeft(@AutoItExe, StringInStr(@AutoItExe, "\", 0, -1) - 1)) ; Find the folder of a full path.

			Case $idGetState
				; Display a message box about the state of the 'About' item.
				MsgBox($MB_SYSTEMMODAL, "", "The state of the 'About' item is: " & TrayItemGetState($idAbout))

			Case $idExit ; Exit the loop.
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>Example
