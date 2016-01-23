#include <ScreenCapture.au3>

Example()

Func Example()
	; Capture full screen
	_ScreenCapture_Capture(@MyDocumentsDir & "\GDIPlus_Image1.jpg")

	ShellExecute(@MyDocumentsDir & "\GDIPlus_Image1.jpg")

	; Capture region
	_ScreenCapture_Capture(@MyDocumentsDir & "\GDIPlus_Image2.jpg", 0, 0, 796, 596)

	ShellExecute(@MyDocumentsDir & "\GDIPlus_Image2.jpg")
EndFunc   ;==>Example
