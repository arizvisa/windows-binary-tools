#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hBrush, $iQuality1, $iQuality2, $hMatrix

	; Create GUI
	$hGUI = GUICreate("GDI+", 800, 400)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, $GDIP_SMOOTHINGMODE_HIGHQUALITY)
	_GDIPlus_GraphicsClear($hGraphic, 0xFF6600AA)

	Local $hPath = _GDIPlus_PathCreate()
	_GDIPlus_PathAddEllipse($hPath, 10, 10, 380, 360)

	$hBrush = _GDIPlus_PathBrushCreateFromPath($hPath)
	_GDIPlus_PathBrushSetCenterColor($hBrush, 0xFFFFFFFF)
	_GDIPlus_PathBrushSetSurroundColor($hBrush, 0)
	_GDIPlus_PathBrushSetSigmaBlend($hBrush, 1)
	_GDIPlus_PathBrushSetFocusScales($hBrush, 0.7, 0.7)
	_GDIPlus_GraphicsFillPath($hGraphic, $hPath, $hBrush)

	$iQuality1 = _GDIPlus_GraphicsGetCompositingQuality($hGraphic)

	$hMatrix = _GDIPlus_MatrixCreate()
	_GDIPlus_MatrixTranslate($hMatrix, 400, 0)
	_GDIPlus_PathTransform($hPath, $hMatrix)
	_GDIPlus_PathBrushSetTransform($hBrush, $hMatrix)

	_GDIPlus_GraphicsSetCompositingQuality($hGraphic, 3)
	_GDIPlus_GraphicsFillPath($hGraphic, $hPath, $hBrush)
	$iQuality2 = _GDIPlus_GraphicsGetCompositingQuality($hGraphic)

	_GDIPlus_GraphicsDrawString($hGraphic, "CompositingQuality = " & $iQuality1, 10, 380)
	_GDIPlus_GraphicsDrawString($hGraphic, "CompositingQuality = " & $iQuality2, 420, 380)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_MatrixDispose($hMatrix)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
