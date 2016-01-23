#NoTrayIcon
#include <MsgBoxConstants.au3>
#include <TrayConstants.au3> ; Required for the $TRAY_ICONSTATE_SHOW, $TRAY_ITEM_EXIT and $TRAY_ITEM_PAUSE constants.

Opt("TrayAutoPause", 0) ; The script will not pause when selecting the tray icon.
Opt("TrayMenuMode", 2) ; Items are not checked when selected.

Example()

Func Example()
	Local $idRandom = TrayCreateItem("Random:") ; Select this item to change the text with a random number.
	TrayCreateItem("") ; Create a separator line.

	Local $idAbout = TrayCreateItem("About")

	TraySetState($TRAY_ICONSTATE_SHOW) ; Show the tray menu.

	TrayItemSetText($TRAY_ITEM_EXIT, "Exit Program") ; Set the text of the default 'Exit' item.
	TrayItemSetText($TRAY_ITEM_PAUSE, "Pause Program") ; Set the text of the default 'Pause' item.

	While 1
		Switch TrayGetMsg()
			Case $idAbout ; Display a message box about the AutoIt version and installation path of the AutoIt executable.
				MsgBox($MB_SYSTEMMODAL, "", "AutoIt tray menu example." & @CRLF & @CRLF & _
						"Version: " & @AutoItVersion & @CRLF & _
						"Install Path: " & StringLeft(@AutoItExe, StringInStr(@AutoItExe, "\", 0, -1) - 1)) ; Find the folder of a full path.

			Case $idRandom
				; Set the text of the 'Random' item with a random integer.
				TrayItemSetText($idRandom, "Random: " & Int(Random(1, 10, 1)))

		EndSwitch
	WEnd
EndFunc   ;==>Example
