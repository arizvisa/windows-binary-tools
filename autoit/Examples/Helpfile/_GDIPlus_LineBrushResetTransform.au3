#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hBrush

	$hGUI = GUICreate("GDI+", 420, 420)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	$hBrush = _GDIPlus_LineBrushCreate(10, 10, 410, 410, 0xFF000000, 0xFFFFFFFF, 3)
	_GDIPlus_LineBrushSetSigmaBlend($hBrush, 1)

	_GDIPlus_LineBrushResetTransform($hBrush) ;reset angle to zero

	_GDIPlus_GraphicsFillRect($hGraphic, 10, 10, 400, 400, $hBrush)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
