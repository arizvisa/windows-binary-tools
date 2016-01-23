#include <ScreenCapture.au3>

Example()

Func Example()
	; Capture full screen
	_ScreenCapture_SetBMPFormat(0)
	_ScreenCapture_Capture(@MyDocumentsDir & "\GDIPlus_Image.bmp")

	ShellExecute(@MyDocumentsDir & "\GDIPlus_Image.bmp")
EndFunc   ;==>Example
