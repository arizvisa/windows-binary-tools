#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Global $g_hGUI, $g_hBrush, $g_hGfx, $g_hGfxCtxt, $g_hBitmap

Example()

Func Example()
	AutoItSetOption("GUIOnEventMode", 1)

	_GDIPlus_Startup() ;initialize GDI+
	Local Const $iWidth = 600, $iHeight = 600, $iBgColor = 0x303030 ;$iBGColor format RRGGBB

	$g_hGUI = GUICreate("GDI+ Example (" & @ScriptName & ")", $iWidth, $iHeight) ;create a test GUI
	GUISetBkColor($iBgColor, $g_hGUI) ;set GUI background color
	GUISetState(@SW_SHOW)

	;create buffered graphics frame set for smoother gfx object movements
	$g_hGfx = _GDIPlus_GraphicsCreateFromHWND($g_hGUI) ;create a graphics object from a window handle
	$g_hBitmap = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $g_hGfx) ;create a Bitmap object based on a graphics object
	$g_hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($g_hBitmap) ;get the graphics context of the image / bitmap to draw on image / bitmap
	_GDIPlus_GraphicsSetSmoothingMode($g_hGfxCtxt, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;sets the graphics object rendering quality (antialiasing)

	$g_hBrush = _GDIPlus_BrushCreateSolid(0xFF8080FF) ;create a solid Brush object

	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

	Local Const $iDeg = ACos(-1) / 180 ;ACos(-1) is nearly pi
	Local $iSize = 50, $iX_Center = ($iWidth - $iSize) / 2, $iY_Center = ($iHeight - $iSize) / 2, $iXPos, $iYPos, $iAngle = 0
	Local Const $iDots = 16, $iAngelDist = 360 / $iDots, $iRadius = 200

	Do
		_GDIPlus_GraphicsClear($g_hGfxCtxt, 0xFF000000 + $iBgColor) ;clear bitmap with given color (AARRGGBB format)
		For $i = 1 To $iDots
			$iXPos = $iX_Center + Cos($iAngle * $iDeg) * $iRadius
			$iYPos = $iY_Center + Sin($iAngle * $iDeg) * $iRadius
			_GDIPlus_GraphicsFillEllipse($g_hGfxCtxt, $iXPos, $iYPos, $iSize, $iSize, $g_hBrush) ;draw dots in a circle
			$iAngle += $iAngelDist ;increase angle to next dot
		Next
		$iAngle += 1 ;increase overall angle
		_GDIPlus_GraphicsDrawImageRect($g_hGfx, $g_hBitmap, 0, 0, $iWidth, $iHeight) ;copy drawn bitmap to GUI
	Until Not Sleep(20) ;Sleep() always returns 1 and Not 1 is 0
EndFunc   ;==>Example

Func _Exit() ;cleanup GDI+ resources
	_GDIPlus_BrushDispose($g_hBrush)
	_GDIPlus_GraphicsDispose($g_hGfxCtxt)
	_GDIPlus_GraphicsDispose($g_hGfx)
	_GDIPlus_BitmapDispose($g_hBitmap)
	_GDIPlus_Shutdown()
	GUIDelete($g_hGUI)
	Exit
EndFunc   ;==>_Exit
