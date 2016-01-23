#include <ScreenCapture.au3>

Example()

Func Example()
	Local $hGUI

	; Create GUI
	$hGUI = GUICreate("Screen Capture", 400, 300)
	GUISetState(@SW_SHOW)
	Sleep(250)

	; Capture window
	_ScreenCapture_CaptureWnd(@MyDocumentsDir & "\GDIPlus_Image.jpg", $hGUI)

	ShellExecute(@MyDocumentsDir & "\GDIPlus_Image.jpg")
EndFunc   ;==>Example
