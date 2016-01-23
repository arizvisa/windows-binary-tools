#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI = GUICreate("GDI+", 320, 240)
	GUICtrlCreateButton("Button", 20, 20, 100, 25)
	GUICtrlCreateSlider(100, 100, 100, 30)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle

	_GDIPlus_GraphicsSetClipRect($hGraphics, 20, 20, 100, 25, 4) ;subtract button-area from clipregion
	_GDIPlus_GraphicsSetClipRect($hGraphics, 100, 100, 100, 30, 4) ;subtract slider-area from clipregion

	Local $iTimer = TimerInit()
	; Loop until the user exits.
	Do
		If TimerDiff($iTimer) > 100 Then
			_GDIPlus_GraphicsClear($hGraphics, BitOR(0xFF000000, Random(0, 0xFFFFFF, 1)))
			$iTimer = TimerInit()
		EndIf
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
