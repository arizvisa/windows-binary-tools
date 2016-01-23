#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>

Global $g_hGUI, $g_hGfxCtxt, $g_hBitmap, $g_hBMP, $g_hGraphics

Example()

Func Example()
	AutoItSetOption("GUIOnEventMode", 1)

	_GDIPlus_Startup() ;initialize GDI+
	Local Const $iWidth = 600, $iHeight = 600, $iBgColor = 0x303030 ;$iBGColor format RRGGBB

	$g_hGUI = GUICreate("GDI+ Example (" & @ScriptName & ")", $iWidth, $iHeight) ;create a test GUI
	GUISetBkColor($iBgColor, $g_hGUI) ;set GUI background color
	GUISetState(@SW_SHOW)

	;create buffered graphics frame set for smoother gfx object movements
	$g_hGraphics = _GDIPlus_GraphicsCreateFromHWND($g_hGUI) ;create a graphics object from a window handle
	$g_hBitmap = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $g_hGraphics)
	$g_hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($g_hBitmap)
	Local Const $iW = 300, $iH = 300
	Local $hHBmp = _ScreenCapture_Capture("", 0, @DesktopHeight - $iH, $iW, @DesktopHeight) ;create a GDI bitmap by capturing an area on desktop
	$g_hBMP = _GDIPlus_BitmapCreateFromHBITMAP($hHBmp) ;convert GDI to GDI+ bitmap
	_WinAPI_DeleteObject($hHBmp) ;release GDI bitmap resource because not needed anymore
	Local $iVectorX = Random(1.5, 2.5), $iVectorY = Random(1.5, 2.5) ;define x and y vector
	Local $iX = 0.0, $iY = 0.0 ;define start coordinate

	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

	Do
		_GDIPlus_GraphicsClear($g_hGfxCtxt, 0xFF000000 + $iBgColor) ;clear bitmap for repaint
		_GDIPlus_GraphicsDrawImageRect($g_hGfxCtxt, $g_hBMP, $iX, $iY, $iW, $iH) ;draw bitmap to backbuffer
		_GDIPlus_GraphicsDrawImageRect($g_hGraphics, $g_hBitmap, 0, 0, $iWidth, $iHeight) ;copy drawn bitmap to graphics handle (GUI)
		$iX += $iVectorX ;add x vector to current x position
		$iY += $iVectorY ;add y vector to current y position
		If $iX < 0 Or $iX > ($iWidth - $iW) Then $iVectorX *= -1 ;when x border is reached reverse x vector
		If $iY < 0 Or $iY > ($iHeight - $iH) Then $iVectorY *= -1 ;when y border is reached reverse y vector
	Until Not Sleep(20) ;sleep 20 ms to avoid high cpu usage
EndFunc   ;==>Example

Func _Exit()
	;cleanup GDI+ resources
	_GDIPlus_GraphicsDispose($g_hGfxCtxt)
	_GDIPlus_GraphicsDispose($g_hGraphics)
	_GDIPlus_BitmapDispose($g_hBitmap)
	_GDIPlus_BitmapDispose($g_hBMP)
	_GDIPlus_Shutdown()
	GUIDelete($g_hGUI)
	Exit
EndFunc   ;==>_Exit
