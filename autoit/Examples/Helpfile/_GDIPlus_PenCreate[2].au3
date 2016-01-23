#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Global $g_hGUI, $g_hGraphics, $g_hBitmap, $g_hGfxCtxt, $g_hPen

Example()

Func Example()
	AutoItSetOption("GUIOnEventMode", 1)

	_GDIPlus_Startup() ;initialize GDI+
	Local $iW = 600, $iH = 600
	Local Const $iBgColor = 0x303030 ;$iBGColor format RRGGBB

	$g_hGUI = GUICreate("GDI+ Example (" & @ScriptName & ")", $iW, $iH) ;create a test GUI
	GUISetBkColor($iBgColor, $g_hGUI) ;set GUI background color
	GUISetState(@SW_SHOW)

	;create buffered graphics frame set for smoother gfx object movements
	$g_hGraphics = _GDIPlus_GraphicsCreateFromHWND($g_hGUI) ;create a graphics object from a window handle
	$g_hBitmap = _GDIPlus_BitmapCreateFromGraphics($iW, $iH, $g_hGraphics)
	$g_hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($g_hBitmap)
	_GDIPlus_GraphicsSetSmoothingMode($g_hGfxCtxt, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;sets the graphics object rendering quality (antialiasing)
	$g_hPen = _GDIPlus_PenCreate(0xFF8080FF, 2)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

	Local Const $fDeg = ACos(-1) / 180, $iRadius = 300, $iWidth = $iW / 2, $iHeight = $iH / 2
	Local $fAngle = 0

	Do
		_GDIPlus_GraphicsClear($g_hGfxCtxt, 0xFF000000 + $iBgColor) ;clear bitmap for repaint
		_GDIPlus_GraphicsDrawEllipse($g_hGfxCtxt, $iWidth - $iRadius / 2 + $iRadius / 18, $iHeight - $iRadius / 2 + $iRadius / 18, $iRadius - $iRadius / 9, $iRadius - $iRadius / 9, $g_hPen) ;draw ellipse
		_GDIPlus_GraphicsDrawLine($g_hGfxCtxt, $iWidth + Cos($fAngle * $fDeg) * $iRadius, $iHeight + Sin($fAngle * $fDeg) * $iRadius, _ ;draw line
				$iWidth + Cos($fAngle * $fDeg + 180) * $iRadius, $iHeight + Sin($fAngle * $fDeg + 180) * $iRadius, $g_hPen)

		_GDIPlus_GraphicsDrawImageRect($g_hGraphics, $g_hBitmap, 0, 0, $iW, $iH) ;copy drawn bitmap to graphics handle (GUI)
		$fAngle += 0.5
	Until Not Sleep(20) ;sleep 20 ms to avoid high cpu usage
EndFunc   ;==>Example

Func _Exit()
	;cleanup GDI+ resources
	_GDIPlus_PenDispose($g_hPen)
	_GDIPlus_GraphicsDispose($g_hGfxCtxt)
	_GDIPlus_GraphicsDispose($g_hGraphics)
	_GDIPlus_BitmapDispose($g_hBitmap)
	_GDIPlus_Shutdown()
	GUIDelete($g_hGUI)
	Exit
EndFunc   ;==>_Exit
