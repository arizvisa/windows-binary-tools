#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hBrush, $hPath1, $hPath2, $hMatrix

	; Create GUI
	$hGUI = GUICreate("GDI+", 800, 200)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;Sets the graphics object rendering quality (antialiasing)
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	$hBrush = _GDIPlus_BrushCreateSolid(0xFFFF0000)

	$hPath1 = _GDIPlus_PathCreate() ;Create new path object
	For $i = 1 To 9
		_GDIPlus_PathAddRectangle($hPath1, 20 * $i, 10, 10, 180)
	Next

	$hPath2 = _GDIPlus_PathCreate() ;Create new path object
	For $i = 1 To 9
		_GDIPlus_PathAddRectangle($hPath2, 10, 20 * $i, 180, 10)
	Next

	_GDIPlus_GraphicsFillPath($hGraphic, $hPath1, $hBrush) ;Draw path1 to graphics handle (GUI)

	_GDIPlus_PathAddPath($hPath1, $hPath2) ;add path2 to path1

	$hMatrix = _GDIPlus_MatrixCreate()
	_GDIPlus_MatrixTranslate($hMatrix, 300, 0)
	_GDIPlus_PathTransform($hPath2, $hMatrix) ;move path2 to an offset of 300
	_GDIPlus_GraphicsFillPath($hGraphic, $hPath2, $hBrush) ;Draw path2 to graphics handle (GUI)

	_GDIPlus_MatrixTranslate($hMatrix, 300, 0)
	_GDIPlus_PathTransform($hPath1, $hMatrix) ;move path1+Path2 to an offset of 600
	_GDIPlus_GraphicsFillPath($hGraphic, $hPath1, $hBrush) ;Draw path1 to graphics handle (GUI)

	_GDIPlus_GraphicsDrawString($hGraphic, "+", 180, 10, "Arial Black", 100)
	_GDIPlus_GraphicsDrawString($hGraphic, "=", 480, 10, "Arial Black", 100)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_MatrixDispose($hMatrix)
	_GDIPlus_PathDispose($hPath1)
	_GDIPlus_PathDispose($hPath2)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
