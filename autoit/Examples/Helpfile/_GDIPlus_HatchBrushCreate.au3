#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hBrush, $iX, $iY

	; Create GUI
	Local $hGUI = GUICreate("GDI+", 810, 610)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	Local $hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle

	For $i = 0 To 52
		$iX = 10 + Mod($i, 10) * 80
		$iY = 30 + Floor($i / 10) * 100
		_GDIPlus_GraphicsDrawString($hGraphic, $i, $iX, $iY - 16)

		$hBrush = _GDIPlus_HatchBrushCreate($i, 0xFF00FF00, 0xFF0000FF)
		_GDIPlus_GraphicsFillRect($hGraphic, $iX, $iY, 70, 70, $hBrush)

		_GDIPlus_BrushDispose($hBrush)
	Next

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
