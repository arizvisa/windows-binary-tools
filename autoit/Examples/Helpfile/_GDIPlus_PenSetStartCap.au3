#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hPen

	; Create GUI
	$hGUI = GUICreate("GDI+", 400, 400)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;Sets the graphics object rendering quality (antialiasing)
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	$hPen = _GDIPlus_PenCreate(0xFFAA00FF, 40)
	_GDIPlus_PenSetStartCap($hPen, $GDIP_LINECAPROUND)
	_GDIPlus_PenSetEndCap($hPen, $GDIP_LINECAPROUND)

	_GDIPlus_GraphicsDrawArc($hGraphic, 60, 60, 280, 280, 135, 270, $hPen)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
