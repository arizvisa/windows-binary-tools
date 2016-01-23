#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hPen, $hPath

	; Create GUI
	$hGUI = GUICreate("GDI+", 800, 300)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;Sets the graphics object rendering quality (antialiasing)
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	$hPen = _GDIPlus_PenCreate(0xFF8800AA, 2)

	$hPath = _GDIPlus_PathCreate() ;Create new path object

	_GDIPlus_PathAddLine($hPath, 40, 100, 140, 200)
	_GDIPlus_PathAddLine($hPath, 240, 100, 340, 200)

	_GDIPlus_PathStartFigure($hPath);next line will not be connected to last point

	_GDIPlus_PathAddLine($hPath, 440, 100, 540, 200)
	_GDIPlus_PathAddLine($hPath, 640, 100, 740, 200)

	_GDIPlus_GraphicsDrawPath($hGraphic, $hPath, $hPen)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
