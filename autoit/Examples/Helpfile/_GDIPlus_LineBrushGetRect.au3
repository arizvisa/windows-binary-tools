#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hBrush, $aRect

	$hGUI = GUICreate("GDI+", 400, 300)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	$hBrush = _GDIPlus_LineBrushCreate(10, 10, 390, 290, 0xFF000000, 0xFFFFFFFF)

	$aRect = _GDIPlus_LineBrushGetRect($hBrush)
	_GDIPlus_GraphicsFillRect($hGraphic, $aRect[0], $aRect[1], $aRect[2], $aRect[3], $hBrush)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
