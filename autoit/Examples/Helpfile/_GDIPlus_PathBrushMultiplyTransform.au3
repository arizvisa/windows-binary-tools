#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hBrush, $hPath, $hMatrix

	; Create GUI
	$hGUI = GUICreate("GDI+", 400, 400)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;Sets the graphics object rendering quality (antialiasing)
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	$hPath = _GDIPlus_PathCreate() ;Create new path object
	_GDIPlus_PathAddEllipse($hPath, 10, 10, 380, 380)

	$hBrush = _GDIPlus_PathBrushCreateFromPath($hPath)
	_GDIPlus_PathBrushSetCenterPoint($hBrush, 200, 100)
	_GDIPlus_PathBrushSetCenterColor($hBrush, 0xFFFFFFFF)
	_GDIPlus_PathBrushSetSurroundColor($hBrush, 0xFFAA00FF)
	_GDIPlus_PathBrushSetSigmaBlend($hBrush, 1)
	_GDIPlus_PathBrushSetGammaCorrection($hBrush, True)

	$hMatrix = _GDIPlus_MatrixCreate()
	_GDIPlus_MatrixTranslate($hMatrix, -200, -200)
	_GDIPlus_MatrixRotate($hMatrix, 1, True)
	_GDIPlus_MatrixTranslate($hMatrix, 200, 200, True)

	For $i = 1 To 360
		_GDIPlus_GraphicsFillPath($hGraphic, $hPath, $hBrush)
		_GDIPlus_PathBrushMultiplyTransform($hBrush, $hMatrix, True)
		Sleep(10)
	Next

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
