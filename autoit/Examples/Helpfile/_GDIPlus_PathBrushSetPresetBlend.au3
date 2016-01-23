#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI = GUICreate("GDI+", 200, 180)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $GDIP_SMOOTHINGMODE_HIGHQUALITY)
	_GDIPlus_GraphicsClear($hGraphics, 0xFF000000)

	Local $hPath = _GDIPlus_PathCreate()
	_GDIPlus_PathAddEllipse($hPath, 10, 10, 180, 160)

	Local $hBrush = _GDIPlus_PathBrushCreateFromPath($hPath)
	_GDIPlus_PathBrushSetCenterPoint($hBrush, 100, 90)

	Local $aBlend[4][2] = [[3]]
	$aBlend[1][0] = 0xFFFF0000 ;red
	$aBlend[1][1] = 0 ;position = boundary
	$aBlend[2][0] = 0xFF00FF00 ;green
	$aBlend[2][1] = 0.7 ;70% of distance boundary->center point
	$aBlend[3][0] = 0xFF0000FF ;blue
	$aBlend[3][1] = 1 ;center point
	_GDIPlus_PathBrushSetPresetBlend($hBrush, $aBlend)

	Local $aRect = _GDIPlus_PathBrushGetRect($hBrush)
	_GDIPlus_GraphicsFillRect($hGraphics, $aRect[0], $aRect[1], $aRect[2], $aRect[3], $hBrush)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
