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
	Local $hPen = _GDIPlus_PenCreate(0xFFFFFFFF, 4) ;color format AARRGGBB (hex)

	Local $aPoints[8][2]
	$aPoints[0][0] = 7
	$aPoints[1][0] = 50.5
	$aPoints[1][1] = 50.5
	$aPoints[2][0] = 100.75
	$aPoints[2][1] = 25.33
	$aPoints[3][0] = 200.66
	$aPoints[3][1] = 5.5
	$aPoints[4][0] = 250.25
	$aPoints[4][1] = 50.75
	$aPoints[5][0] = 300.125
	$aPoints[5][1] = 100.375
	$aPoints[6][0] = 590.8
	$aPoints[6][1] = 200.222
	$aPoints[7][0] = 250.55
	$aPoints[7][1] = 590.45

	_GDIPlus_GraphicsDrawClosedCurve($hGraphics, $aPoints, $hPen)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	;cleanup GDI+ resources
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
EndFunc   ;==>Example
