#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	_GDIPlus_Startup() ;initialize GDI+
	Local Const $iWidth = 600, $iHeight = 300, $iBgColor = 0x303030 ;$iBgColor format RRGGBB

	Local $hGUI = GUICreate("GDI+ Example (" & @ScriptName & ")", $iWidth, $iHeight) ;create a test GUI
	GUISetBkColor($iBgColor, $hGUI) ;set GUI background color
	GUISetState(@SW_SHOW)

	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;sets the graphics object rendering quality (antialiasing)

	Local $hBrush = _GDIPlus_LineBrushCreate(0, 0, 580, 280, 0, 0, 1) ;create line brush

	Local $aInterpolations[5][2] ;define the interpolated colors and positions
	$aInterpolations[0][0] = 4
	$aInterpolations[1][0] = 0xFFFF0000 ;Red
	$aInterpolations[1][1] = 0 ;0% from the left
	$aInterpolations[2][0] = 0xFF00FF00 ;Green
	$aInterpolations[2][1] = 0.3 ;To 30% from the left
	$aInterpolations[3][0] = 0xFF0000FF ;Blue
	$aInterpolations[3][1] = 0.7 ;To 70% from the left
	$aInterpolations[4][0] = 0xFFFFFF00 ;Yellow
	$aInterpolations[4][1] = 1 ;To 100% from the left

	_GDIPlus_LineBrushSetPresetBlend($hBrush, $aInterpolations) ;set the linear gradient brush colors and position

	_GDIPlus_GraphicsFillRect($hGraphics, 10, 10, 580, 280, $hBrush) ;draw bitmap to screen

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	;cleanup GDI+ resources
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
EndFunc   ;==>Example
