#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hBrush, $hPen, $hPath, $hFamily, $tLayout

	; Create GUI
	$hGUI = GUICreate("GDI+", 420, 160)
	GUISetState(@SW_SHOW)

	; Draw a string using path
	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	$hBrush = _GDIPlus_BrushCreateSolid(0xFFDD2200)
	$hPen = _GDIPlus_PenCreate(0xFFFFBB00, $GDIP_SMOOTHINGMODE_HIGHQUALITY)

	$hPath = _GDIPlus_PathCreate() ;Create new path object

	$hFamily = _GDIPlus_FontFamilyCreate("Arial") ;Create font family object
	$tLayout = _GDIPlus_RectFCreate() ;Create string bounding rectangle X=0, Y=0
	_GDIPlus_PathAddString($hPath, "AutoIt rulez!", $tLayout, $hFamily, 0, 72, 0) ;Add the outline of the string to the path

	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, 2) ;Sets the graphics object rendering quality (antialiasing)
	_GDIPlus_GraphicsClear($hGraphic, 0xFF000000)
	_GDIPlus_GraphicsFillPath($hGraphic, $hPath, $hBrush) ;Fill path to graphics handle (GUI)
	_GDIPlus_GraphicsDrawPath($hGraphic, $hPath, $hPen) ;Draw path to graphics handle (GUI)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
