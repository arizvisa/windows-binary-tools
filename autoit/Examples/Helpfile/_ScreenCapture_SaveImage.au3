#include <ScreenCapture.au3>

Example()

Func Example()
	Local $hBmp

	; Capture full screen
	$hBmp = _ScreenCapture_Capture("")

	; Save bitmap to file
	_ScreenCapture_SaveImage(@MyDocumentsDir & "\GDIPlus_Image.jpg", $hBmp)

	ShellExecute(@MyDocumentsDir & "\GDIPlus_Image.jpg")
EndFunc   ;==>Example
