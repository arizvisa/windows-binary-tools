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
	Local $hBrush = _GDIPlus_BrushCreateSolid(0xFFFFFFFF) ;color format AARRGGBB (hex)

	;  1 _____ 3
	;    \   /
	;     \ /
	;      2
	Local $aPoints[4][2]
	$aPoints[0][0] = 3
	$aPoints[1][0] = 50.0
	$aPoints[1][1] = 150.0
	$aPoints[2][0] = 300.0
	$aPoints[2][1] = 500.0
	$aPoints[3][0] = 550.0
	$aPoints[3][1] = 150.0

	_GDIPlus_GraphicsFillPolygon($hGraphics, $aPoints, $hBrush) ;draw the triangle

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	;cleanup GDI+ resources
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
EndFunc   ;==>Example
