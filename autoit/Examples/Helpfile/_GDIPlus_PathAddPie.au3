#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hBrush, $hPen, $hPen2, $hPath

	; Create GUI
	$hGUI = GUICreate("GDI+", 400, 400)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;Sets the graphics object rendering quality (antialiasing)
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	$hBrush = _GDIPlus_BrushCreateSolid(0x7F8800AA)
	$hPen = _GDIPlus_PenCreate(0xFF8800AA, 2)

	$hPath = _GDIPlus_PathCreate() ;Create new path object

	_GDIPlus_PathAddPie($hPath, 50, 50, 300, 300, 135, 270)
	_GDIPlus_PathAddPie($hPath, 50, 80, 300, 300, 45, 90)

	_GDIPlus_GraphicsFillPath($hGraphic, $hPath, $hBrush) ;Fill path to graphics handle (GUI)
	_GDIPlus_GraphicsDrawPath($hGraphic, $hPath, $hPen) ;Draw path to graphics handle (GUI)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_PenDispose($hPen2)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
