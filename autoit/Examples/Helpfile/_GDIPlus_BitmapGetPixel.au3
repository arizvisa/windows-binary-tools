#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>

Example()

Func Example()
	_GDIPlus_Startup() ;initialize GDI+
	Local Const $iWidth = 150, $iHeight = 150
	Local $iColor = 0
	Local $hHBmp = _ScreenCapture_Capture("", 0, 0, $iWidth, $iHeight) ;create a GDI bitmap by capturing an area on desktop
	Local $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hHBmp) ;convert GDI to GDI+ bitmap
	_WinAPI_DeleteObject($hHBmp) ;release GDI bitmap resource because not needed anymore

	For $iY = 0 To $iHeight - 1
		For $iX = 0 To $iWidth - 1
			$iColor = _GDIPlus_BitmapGetPixel($hBitmap, $iX, $iY) ;get current pixel color
			_GDIPlus_BitmapSetPixel($hBitmap, $iX, $iY, BitXOR(0x00FFFFFF, $iColor)) ;invert RGB pixel color only
		Next
	Next
	Local $hGUI = GUICreate("GDI+ Example (" & @ScriptName & ")", $iWidth, $iHeight) ;create a test GUI
	GUISetState(@SW_SHOW)

	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;create a graphics object from a window handle
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0) ;copy negative bitmap to graphics object (GUI)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	;cleanup GDI+ resources
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
EndFunc   ;==>Example
