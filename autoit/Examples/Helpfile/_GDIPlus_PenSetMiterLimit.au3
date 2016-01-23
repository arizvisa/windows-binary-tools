#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hPen, $fPenWidth, $hPath

	; Create GUI
	$hGUI = GUICreate("GDI+", 800, 600)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;Sets the graphics object rendering quality (antialiasing)
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	$hPath = _GDIPlus_PathCreate() ;Create new path object
	_GDIPlus_PathAddLine($hPath, 30, 550, 70, 200)
	_GDIPlus_PathAddLine($hPath, 70, 200, 110, 550)

	$fPenWidth = 32

	Local $hPen1 = _GDIPlus_PenCreate(0xFF00FF00, 1)
	For $i = 0 To 6
		_GDIPlus_GraphicsDrawLine($hGraphic, 0, 200 - $fPenWidth * 0.5 * $i, 800, 200 - $fPenWidth * 0.5 * $i, $hPen1)
	Next

	$hPen = _GDIPlus_PenCreate(0xFF8800AA, $fPenWidth)
	For $i = 1 To 6
		_GDIPlus_PenSetMiterLimit($hPen, $i)
		_GDIPlus_GraphicsDrawString($hGraphic, "MiterLimit: " & StringFormat("%.1f", _GDIPlus_PenGetMiterLimit($hPen)), 10, 10)
		_GDIPlus_GraphicsDrawPath($hGraphic, $hPath, $hPen)
		_GDIPlus_GraphicsDrawPath($hGraphic, $hPath, $hPen1)
		_GDIPlus_GraphicsTranslateTransform($hGraphic, 130, 0)
	Next

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_PenDispose($hPen1)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
