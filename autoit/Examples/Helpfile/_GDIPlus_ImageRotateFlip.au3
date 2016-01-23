#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>

Example()

Func Example()
	_GDIPlus_Startup()
	Local Const $iW = @DesktopWidth / 2, $iH = @DesktopHeight / 2

	Local $hHBmp = _ScreenCapture_Capture("", 0, 0, @DesktopWidth / 2, @DesktopHeight / 2) ;create a GDI bitmap by capturing 1/4 of desktop
	Local $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hHBmp) ;convert GDI bitmap to GDI+ bitmap
	_WinAPI_DeleteObject($hHBmp) ;release GDI bitmap resource because not needed anymore
	_GDIPlus_ImageRotateFlip($hBitmap, 1) ;rotate image by 90 degrees without flipping

	Local $hGUI = GUICreate("GDI+ test", $iH, $iW, -1, -1) ;create a test gui to display the rotated image
	GUISetState(@SW_SHOW)

	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;create a graphics object from a window handle
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0) ;display rotated image

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	;cleanup resources
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
EndFunc   ;==>Example
