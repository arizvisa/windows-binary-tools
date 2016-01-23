#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hBrush, $hPen, $hPath

	; Create GUI
	$hGUI = GUICreate("GDI+", 300, 220)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;Sets the graphics object rendering quality (antialiasing)

	$hBrush = _GDIPlus_BrushCreateSolid(0x7F8800AA)
	$hPen = _GDIPlus_PenCreate(0xFF8800AA, 2)

	$hPath = _GDIPlus_PathCreate(0) ;Create new path object
	_GDIPlus_PathAddRectangle($hPath, 50, 50, 100, 100)
	_GDIPlus_PathAddRectangle($hPath, 100, 80, 100, 100)
	_GDIPlus_PathAddRectangle($hPath, 120, 30, 100, 100)

	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)
	_GDIPlus_GraphicsFillPath($hGraphic, $hPath, $hBrush) ;Fill path to graphics handle (GUI)
	_GDIPlus_GraphicsDrawPath($hGraphic, $hPath, $hPen) ;Draw path to graphics handle (GUI)

	; Loop until the user exits.
	Local $iTimer = TimerInit()
	Do
		If TimerDiff($iTimer) > 1000 Then
			_GDIPlus_PathSetFillMode($hPath, Not _GDIPlus_PathGetFillMode($hPath))
			_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)
			_GDIPlus_GraphicsFillPath($hGraphic, $hPath, $hBrush) ;Fill path to graphics handle (GUI)
			_GDIPlus_GraphicsDrawPath($hGraphic, $hPath, $hPen) ;Draw path to graphics handle (GUI)
			$iTimer = TimerInit()
		EndIf
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
