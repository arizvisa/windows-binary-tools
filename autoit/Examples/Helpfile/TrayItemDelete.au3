#NoTrayIcon
#include <MsgBoxConstants.au3>
#include <TrayConstants.au3> ; Required for the $TRAY_ICONSTATE_SHOW constant.

Opt("TrayMenuMode", 3) ; The default tray menu items will not be shown and items are not checked when selected. These are options 1 and 2 for TrayMenuMode.

Example()

Func Example()
	Local $idDelete = TrayCreateItem("Delete")
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

			Case $idDelete
				; Display a message box to ask whether or not to delete the 'Delete' item. If the return value of MsgBox is equal to $IDYES then delete the item.
				If MsgBox(BitOR($MB_YESNO, $MB_SYSTEMMODAL), "", "Do you want to delete the 'Delete' tray menu item?") = $IDYES Then
					TrayItemDelete($idDelete) ; Delete the tray menu item.
				EndIf

			Case $idExit ; Exit the loop.
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>Example
