#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI = GUICreate("GDI+", 200, 180)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $GDIP_SMOOTHINGMODE_HIGHQUALITY)
	_GDIPlus_GraphicsClear($hGraphics, 0xFFFFFFFF)

	Local $hPath = _GDIPlus_PathCreate()
	_GDIPlus_PathAddEllipse($hPath, 10, 10, 180, 160)

	Local $hBrush = _GDIPlus_PathBrushCreateFromPath($hPath)
	_GDIPlus_PathBrushSetCenterColor($hBrush, 0xF08080A0)

	Local $hMatrix = _GDIPlus_MatrixCreate()
	_GDIPlus_MatrixScale($hMatrix, 0.75, 1.25)
	_GDIPlus_PathBrushSetTransform($hBrush, $hMatrix)

	_GDIPlus_GraphicsFillPath($hGraphics, $hPath, $hBrush)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_MatrixDispose($hMatrix)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
