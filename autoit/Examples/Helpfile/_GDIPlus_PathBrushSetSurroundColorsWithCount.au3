#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI = GUICreate("GDI+", 400, 400)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $GDIP_SMOOTHINGMODE_HIGHQUALITY)
	_GDIPlus_GraphicsClear($hGraphics, 0xFF000000)

	Local $hPath = _GDIPlus_PathCreate()
	_GDIPlus_PathAddLine($hPath, 106, 330, 200, 40)
	_GDIPlus_PathAddLine($hPath, 294, 330, 48, 151)
	_GDIPlus_PathAddLine($hPath, 352, 151, 106, 330)
	_GDIPlus_PathWindingModeOutline($hPath)

	Local $hBrush = _GDIPlus_PathBrushCreateFromPath($hPath)

	Local $aColors[11] = [10]
	$aColors[1] = 0xFFFF0000
	$aColors[2] = 0xFF000000
	$aColors[3] = 0xFFFFFF00
	$aColors[4] = 0xFF000000
	$aColors[5] = 0xFF00FF00
	$aColors[6] = 0xFF000000
	$aColors[7] = 0xFF00FFFF
	$aColors[8] = 0xFF000000
	$aColors[9] = 0xFF0000FF
	$aColors[10] = 0xFF000000

	_GDIPlus_PathBrushSetSurroundColorsWithCount($hBrush, $aColors)

	_GDIPlus_GraphicsFillPath($hGraphics, $hPath, $hBrush)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
