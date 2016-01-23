#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI = GUICreate("GDI+", 600, 400)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $GDIP_SMOOTHINGMODE_HIGHQUALITY)
	_GDIPlus_GraphicsClear($hGraphics, 0xFF000000)

	Local $aPoints[4][2] = [[3]]
	$aPoints[1][0] = 0
	$aPoints[1][1] = 0
	$aPoints[2][0] = 100
	$aPoints[2][1] = 30
	$aPoints[3][0] = 50
	$aPoints[3][1] = 80

	Local $hBrush = _GDIPlus_PathBrushCreate($aPoints, 3)
	_GDIPlus_PathBrushSetCenterColor($hBrush, 0xFFFFFFFF)

	Local $aColors[4] = [3]
	$aColors[1] = 0xFFFF0000
	$aColors[2] = 0xFF00FF00
	$aColors[3] = 0xFF0000FF
	_GDIPlus_PathBrushSetSurroundColorsWithCount($hBrush, $aColors)

	_GDIPlus_GraphicsFillRect($hGraphics, 0, 0, 600, 400, $hBrush)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
