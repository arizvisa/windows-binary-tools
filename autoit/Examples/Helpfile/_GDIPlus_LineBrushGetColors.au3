#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	_GDIPlus_Startup() ;initialize GDI+
	Local Const $fWidth = 600, $fHeight = 600, $iBgColor = 0x303030 ;$fBGColor format RRGGBB

	Local $hGUI = GUICreate("GDI+ Example (" & @ScriptName & ")", $fWidth, $fHeight) ;create a test GUI
	GUISetBkColor($iBgColor, $hGUI) ;set GUI background color
	GUISetState(@SW_SHOW)

	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;sets the graphics object rendering quality (antialiasing)
	Local $hBrush = _GDIPlus_LineBrushCreate(0, 0, 150, 0, 0xFF000000 + Random(0x111111, 0xFFFFFF, 1), 0xFF000000 + Random(0x111111, 0xFFFFFF, 1), 1) ;create linear gradient flipped brush

	_GDIPlus_GraphicsClear($hGraphics, 0xFF000000 + $iBgColor) ;clear bitmap
	_GDIPlus_GraphicsFillRect($hGraphics, 100, 50, 380, 500, $hBrush) ;draw the egg again

	Local $aColors = _GDIPlus_LineBrushGetColors($hBrush)
	MsgBox($MB_SYSTEMMODAL, "", "Starting hex color: " & Hex($aColors[0], 8) & @CRLF & "End hex color: " & Hex($aColors[1], 8))

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	;cleanup GDI+ resources
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
EndFunc   ;==>Example
