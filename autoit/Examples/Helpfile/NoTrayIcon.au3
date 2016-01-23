#NoTrayIcon
#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Display a message box about the tray icon appearing once the OK button is selected.
	MsgBox($MB_SYSTEMMODAL, "", "The tray icon will display once OK is selected.")

	; Display the tray icon.
	Opt("TrayIconHide", 0)

	; Wait 5 seconds before closing the script.
	Sleep(5000)
EndFunc   ;==>Example
