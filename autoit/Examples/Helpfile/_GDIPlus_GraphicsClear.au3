#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $hBitmap, $hImage, $hGraphic

	; Initialize GDI+ library
	_GDIPlus_Startup()

	; Capture screen region
	$hBitmap = _ScreenCapture_Capture("", 0, 0, 400, 300)
	$hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)

	; Clear the screen capture
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hImage)
	_GDIPlus_GraphicsClear($hGraphic)

	; Save resultant image
	_GDIPlus_ImageSaveToFile($hImage, @MyDocumentsDir & "\GDIPlus_Image.jpg")

	; Clean up resources
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_ImageDispose($hImage)
	_WinAPI_DeleteObject($hBitmap)

	; Shut down GDI+ library
	_GDIPlus_Shutdown()

	ShellExecute(@MyDocumentsDir & "\GDIPlus_Image.jpg")
EndFunc   ;==>Example
