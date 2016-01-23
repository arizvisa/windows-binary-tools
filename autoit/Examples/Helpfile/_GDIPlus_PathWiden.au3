#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI = GUICreate("GDI+", 800, 400)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $GDIP_SMOOTHINGMODE_HIGHQUALITY)
	_GDIPlus_GraphicsClear($hGraphics, 0xFF000000)

	Local $hPath = _GDIPlus_PathCreate()
	Local $hFormat = _GDIPlus_StringFormatCreate()
	_GDIPlus_StringFormatSetAlign($hFormat, 1)
	Local $hFamily = _GDIPlus_FontFamilyCreate("Arial")
	Local $tLayout = _GDIPlus_RectFCreate(0, 0, 800, 400)
	_GDIPlus_PathAddString($hPath, "AutoIt rulez!", $tLayout, $hFamily, 0, 160, $hFormat)

	Local $hPen_Widen = _GDIPlus_PenCreate(0, 8)
	_GDIPlus_PenSetLineJoin($hPen_Widen, $GDIP_PENSETLINEJOIN_ROUND)
	_GDIPlus_PathWiden($hPath, $hPen_Widen)

	Local $hBrush = _GDIPlus_BrushCreateSolid(0xFF8800AA)
	_GDIPlus_GraphicsFillPath($hGraphics, $hPath, $hBrush)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_PenDispose($hPen_Widen)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
