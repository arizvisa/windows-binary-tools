#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	_GDIPlus_Startup() ;initialize GDI+
	Local Const $iWidth = 600, $iHeight = 600, $iBgColor = 0x303030 ;$iBGColor format RRGGBB

	Local $hGUI = GUICreate("GDI+ Example (" & @ScriptName & ")", $iWidth, $iHeight) ;create a test GUI
	GUISetBkColor($iBgColor, $hGUI) ;set GUI background color
	GUISetState(@SW_SHOW)

	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;sets the graphics object rendering quality (antialiasing)
	Local $hBrush = _GDIPlus_LineBrushCreate(0, 0, 280, 570, 0xFFFFFF00, 0xFF4020FF, 1) ;create linear gradient flipped brush

	Local $aBlends[5][2]
	$aBlends[0][0] = 4 ; Using 4 factors and position
	$aBlends[1][0] = 0 ; Factor
	$aBlends[1][1] = 0 ; Position
	$aBlends[2][0] = 1 ; The percentage of the blending is 100% (red to green is gradually completed in just 20% from the left)
	$aBlends[2][1] = 0.2 ; The distance percentage from the left boundary of the brush is 20%
	$aBlends[3][0] = 0 ; The percentage of the blending is 0% (green to red is gradually completed from 20% to 70% from the left)
	$aBlends[3][1] = 0.7 ; The distance percentage from the left boundary of the brush is 70%
	$aBlends[4][0] = 1 ; The percentage of the blending is 100% (red to green is gradually completed from 70% to 100% from the left)
	$aBlends[4][1] = 1 ; The distance percentage from the left boundary of the brush is 100%

	_GDIPlus_LineBrushSetBlend($hBrush, $aBlends); set the linear gradient brush color positions and factors

	_GDIPlus_GraphicsFillEllipse($hGraphics, 100, 50, 380, 500, $hBrush) ;draw the egg

	Sleep(2000)

	_GDIPlus_GraphicsClear($hGraphics, 0xFF000000 + $iBgColor) ;clear bitmap
	_GDIPlus_LineBrushSetColors($hBrush, 0xFFFFFFFF, 0xFF000000) ;change the color values to greyscale

	_GDIPlus_GraphicsFillEllipse($hGraphics, 100, 50, 380, 500, $hBrush) ;draw the egg again

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	;cleanup GDI+ resources
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
EndFunc   ;==>Example
