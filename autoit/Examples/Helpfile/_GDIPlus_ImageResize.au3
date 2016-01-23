#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>

Example()

Func Example()
	_GDIPlus_Startup()
	Local Const $iW = @DesktopWidth, $iH = @DesktopHeight

	Local $hHBmp = _ScreenCapture_Capture("", 0, 0, $iW, $iH) ;create a GDI bitmap by capturing full screen of the desktop
	Local $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hHBmp) ;convert GDI bitmap to GDI+ bitmap
	_WinAPI_DeleteObject($hHBmp) ;release GDI bitmap resource because not needed anymore

	Local $hBitmap_Scaled = _GDIPlus_ImageResize($hBitmap, $iW / 4, $iH / 4) ;resize image

	Local $hGUI = GUICreate("GDI+ test", $iW / 4, $iH / 4, -1, -1) ;create a test gui to display the resized image
	GUISetState(@SW_SHOW)

	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;create a graphics object from a window handle
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap_Scaled, 0, 0) ;display scaled image

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	;cleanup resources
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_BitmapDispose($hBitmap_Scaled)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
EndFunc   ;==>Example
