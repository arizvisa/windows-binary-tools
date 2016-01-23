#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hBrush, $hPen, $hPath, $hPath_Clone, $hMatrix

	; Create GUI
	$hGUI = GUICreate("GDI+", 800, 400)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;Sets the graphics object rendering quality (antialiasing)
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	$hBrush = _GDIPlus_BrushCreateSolid(0x7F8800AA)
	$hPen = _GDIPlus_PenCreate(0xFF8800AA, 2)

	$hPath = _GDIPlus_PathCreate() ;Create new path object

	_GDIPlus_PathAddLine($hPath, 106, 330, 200, 40)
	_GDIPlus_PathAddLine($hPath, 294, 330, 48, 151)
	_GDIPlus_PathAddLine($hPath, 352, 151, 106, 330)

	$hPath_Clone = _GDIPlus_PathClone($hPath) ;Create a copy of the path
	$hMatrix = _GDIPlus_MatrixCreate()
	_GDIPlus_MatrixTranslate($hMatrix, 400, 0)
	_GDIPlus_PathTransform($hPath_Clone, $hMatrix)

	_GDIPlus_PathWindingModeOutline($hPath_Clone) ;Outline

	_GDIPlus_GraphicsDrawString($hGraphic, "original path of 3 connected lines", 40, 10)
	_GDIPlus_GraphicsFillPath($hGraphic, $hPath, $hBrush) ;Fill path to graphics handle (GUI)
	_GDIPlus_GraphicsDrawPath($hGraphic, $hPath, $hPen) ;Draw path to graphics handle (GUI)

	_GDIPlus_GraphicsDrawString($hGraphic, "WindingModeOutline", 440, 10)
	_GDIPlus_GraphicsFillPath($hGraphic, $hPath_Clone, $hBrush) ;Fill path to graphics handle (GUI)
	_GDIPlus_GraphicsDrawPath($hGraphic, $hPath_Clone, $hPen) ;Draw path to graphics handle (GUI)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_MatrixDispose($hMatrix)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_PathDispose($hPath_Clone)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
