#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI = GUICreate("GDI+ test", 640, 480)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	Local $hPen = _GDIPlus_PenCreate()
	_GDIPlus_GraphicsDrawLine($hGraphics, 40, 40, 600, 440, $hPen) ;draw a test line to show smoothing effect (default no smoothing)
	MsgBox($MB_SYSTEMMODAL, "", "Smoothing enabled: " & _GDIPlus_GraphicsGetSmoothingMode($hGraphics))

	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;set smoothing mode (8 X 4 box filter)
	_GDIPlus_GraphicsDrawLine($hGraphics, 600, 40, 40, 440, $hPen) ;draw a test line to show smoothing effect

	MsgBox($MB_SYSTEMMODAL, "", "Smoothing enabled: " & _GDIPlus_GraphicsGetSmoothingMode($hGraphics))

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	;cleanup resources
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
EndFunc   ;==>Example
