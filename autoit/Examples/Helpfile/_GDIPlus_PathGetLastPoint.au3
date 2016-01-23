#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hPen, $hPath, $aPnt

	; Create GUI
	$hGUI = GUICreate("GDI+", 400, 400)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;Sets the graphics object rendering quality (antialiasing)
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	$hPen = _GDIPlus_PenCreate(0xFF8800AA, 2)

	$hPath = _GDIPlus_PathCreate() ;Create new path object

	_GDIPlus_PathAddArc($hPath, 50, 50, 300, 300, Random(0, 360), Random(30, 270))
	_GDIPlus_GraphicsDrawPath($hGraphic, $hPath, $hPen) ;Draw path to graphics handle (GUI)

	_GDIPlus_PenSetColor($hPen, 0xFF00AA00)

	$aPnt = _GDIPlus_PathGetLastPoint($hPath)
	_GDIPlus_GraphicsDrawRect($hGraphic, $aPnt[0] - 5, $aPnt[1] - 5, 10, 10, $hPen)

	_GDIPlus_PathReverse($hPath)
	$aPnt = _GDIPlus_PathGetLastPoint($hPath)
	_GDIPlus_GraphicsDrawRect($hGraphic, $aPnt[0] - 5, $aPnt[1] - 5, 10, 10, $hPen)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
