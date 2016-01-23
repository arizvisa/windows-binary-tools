#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hBrush, $hPen, $hPen2, $hPath

	; Create GUI
	$hGUI = GUICreate("GDI+", 800, 300)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;Sets the graphics object rendering quality (antialiasing)
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	$hBrush = _GDIPlus_BrushCreateSolid(0x7F8800AA)
	$hPen = _GDIPlus_PenCreate(0xFF8800AA, 2)
	$hPen2 = _GDIPlus_PenCreate(0xFFFF0000, 2)

	Local $aPoints[5][2] = [[4]]
	$aPoints[1][0] = 10
	$aPoints[1][1] = 70
	$aPoints[2][0] = 60
	$aPoints[2][1] = 50
	$aPoints[3][0] = 110
	$aPoints[3][1] = 120
	$aPoints[4][0] = 160
	$aPoints[4][1] = 80

	$hPath = _GDIPlus_PathCreate() ;Create new path object

	_GDIPlus_GraphicsDrawString($hGraphic, "Curve", $aPoints[1][0], 20)
	_GDIPlus_PathAddCurve($hPath, $aPoints)
	For $i = 1 To $aPoints[0][0]
		_GDIPlus_GraphicsDrawRect($hGraphic, $aPoints[$i][0] - 4, $aPoints[$i][1] - 4, 8, 8, $hPen2)
		$aPoints[$i][0] += 200
	Next

	_GDIPlus_GraphicsDrawString($hGraphic, "ClosedCurve", $aPoints[1][0], 20)
	_GDIPlus_PathAddClosedCurve($hPath, $aPoints)
	For $i = 1 To $aPoints[0][0]
		_GDIPlus_GraphicsDrawRect($hGraphic, $aPoints[$i][0] - 4, $aPoints[$i][1] - 4, 8, 8, $hPen2)
		$aPoints[$i][0] += 200
	Next

	_GDIPlus_GraphicsDrawString($hGraphic, "Curve2 tension = 0.8", $aPoints[1][0], 20)
	_GDIPlus_PathAddCurve2($hPath, $aPoints, 0.8)
	For $i = 1 To $aPoints[0][0]
		_GDIPlus_GraphicsDrawRect($hGraphic, $aPoints[$i][0] - 4, $aPoints[$i][1] - 4, 8, 8, $hPen2)
		$aPoints[$i][0] += 200
	Next

	_GDIPlus_GraphicsDrawString($hGraphic, "ClosedCurve2 tension = 0.8", $aPoints[1][0], 20)
	_GDIPlus_PathAddClosedCurve2($hPath, $aPoints, 0.8)
	For $i = 1 To $aPoints[0][0]
		_GDIPlus_GraphicsDrawRect($hGraphic, $aPoints[$i][0] - 4, $aPoints[$i][1] - 4, 8, 8, $hPen2)
		$aPoints[$i][0] -= 500
		$aPoints[$i][1] += 140
	Next

	_GDIPlus_GraphicsDrawString($hGraphic, "Curve2 tension = 0", $aPoints[1][0], 160)
	_GDIPlus_PathAddCurve2($hPath, $aPoints, 0)
	For $i = 1 To $aPoints[0][0]
		_GDIPlus_GraphicsDrawRect($hGraphic, $aPoints[$i][0] - 4, $aPoints[$i][1] - 4, 8, 8, $hPen2)
		$aPoints[$i][0] += 200
	Next

	_GDIPlus_GraphicsDrawString($hGraphic, "ClosedCurve2 tension = 0", $aPoints[1][0], 160)
	_GDIPlus_PathAddClosedCurve2($hPath, $aPoints, 0)
	For $i = 1 To $aPoints[0][0]
		_GDIPlus_GraphicsDrawRect($hGraphic, $aPoints[$i][0] - 4, $aPoints[$i][1] - 4, 8, 8, $hPen2)
		$aPoints[$i][0] += 200
	Next

	_GDIPlus_GraphicsDrawString($hGraphic, "Polygon", $aPoints[1][0], 160)
	_GDIPlus_PathAddPolygon($hPath, $aPoints)
	For $i = 1 To $aPoints[0][0]
		_GDIPlus_GraphicsDrawRect($hGraphic, $aPoints[$i][0] - 4, $aPoints[$i][1] - 4, 8, 8, $hPen2)
	Next

	_GDIPlus_GraphicsFillPath($hGraphic, $hPath, $hBrush) ;Fill path to graphics handle (GUI)
	_GDIPlus_GraphicsDrawPath($hGraphic, $hPath, $hPen) ;Draw path to graphics handle (GUI)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_PenDispose($hPen2)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
