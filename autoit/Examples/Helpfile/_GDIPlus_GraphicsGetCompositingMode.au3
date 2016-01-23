#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hBitmap, $hContext, $hBrush, $iMode1, $iMode2

	; Create GUI
	$hGUI = GUICreate("GDI+", 800, 400)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	$hBitmap = _GDIPlus_BitmapCreateFromScan0(800, 400)
	$hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)

	$hBrush = _GDIPlus_LineBrushCreate(0, 0, 0, 400, 0xFF0000FF, 0)

	_GDIPlus_GraphicsFillRect($hContext, 10, 10, 300, 300, $hBrush)
	_GDIPlus_GraphicsFillRect($hContext, 80, 60, 300, 300, $hBrush)
	$iMode1 = _GDIPlus_GraphicsGetCompositingMode($hContext)

	_GDIPlus_GraphicsSetCompositingMode($hContext, $GDIP_CompositingModeSourceCopy)
	_GDIPlus_GraphicsFillRect($hContext, 420, 10, 300, 300, $hBrush)
	_GDIPlus_GraphicsFillRect($hContext, 490, 60, 300, 300, $hBrush)
	$iMode2 = _GDIPlus_GraphicsGetCompositingMode($hContext)

	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)
	_GDIPlus_GraphicsDrawImage($hGraphic, $hBitmap, 0, 0)

	_GDIPlus_GraphicsDrawString($hGraphic, "CompositingMode = " & $iMode1, 10, 380)
	_GDIPlus_GraphicsDrawString($hGraphic, "CompositingMode = " & $iMode2, 420, 380)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_GraphicsDispose($hContext)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
