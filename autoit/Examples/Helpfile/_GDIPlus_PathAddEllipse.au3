#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hPen1, $hPen2, $hPath, $aPoints

	; Create GUI
	$hGUI = GUICreate("GDI+", 800, 400)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;Sets the graphics object rendering quality (antialiasing)
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	$hPen1 = _GDIPlus_PenCreate(0xFFFFBB00, 2)
	$hPen2 = _GDIPlus_PenCreate(0xFF0000FF, 2)

	; original ellipse
	_GDIPlus_GraphicsDrawString($hGraphic, "original ellipse as bezier points", 10, 10)

	$hPath = _GDIPlus_PathCreate() ;Create new path object
	_GDIPlus_PathAddEllipse($hPath, 50, 50, 300, 300)

	_GDIPlus_GraphicsDrawPath($hGraphic, $hPath, $hPen1) ;Draw path to graphics handle (GUI)

	$aPoints = _GDIPlus_PathGetPoints($hPath)
	For $i = 1 To $aPoints[0][0]
		_GDIPlus_GraphicsDrawEllipse($hGraphic, $aPoints[$i][0] - 4, $aPoints[$i][1] - 4, 8, 8, $hPen2)
	Next

	;flattened ellipse
	_GDIPlus_GraphicsDrawString($hGraphic, "flattened ellipse as a sequence of straight lines", 410, 10)

	_GDIPlus_PathReset($hPath)
	_GDIPlus_PathAddEllipse($hPath, 450, 50, 300, 300)
	_GDIPlus_PathFlatten($hPath, 10)

	_GDIPlus_GraphicsDrawPath($hGraphic, $hPath, $hPen1) ;Draw path to graphics handle (GUI)

	$aPoints = _GDIPlus_PathGetPoints($hPath)
	For $i = 1 To $aPoints[0][0]
		_GDIPlus_GraphicsDrawEllipse($hGraphic, $aPoints[$i][0] - 4, $aPoints[$i][1] - 4, 8, 8, $hPen2)
	Next

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_PenDispose($hPen1)
	_GDIPlus_PenDispose($hPen2)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
