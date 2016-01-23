#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI = GUICreate("GDI+", 600, 300)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	Local $hBmp_Buffer = _GDIPlus_BitmapCreateFromGraphics(600, 300, $hGraphics)
	Local $hGfx_Buffer = _GDIPlus_ImageGetGraphicsContext($hBmp_Buffer)
	_GDIPlus_GraphicsSetSmoothingMode($hGfx_Buffer, $GDIP_SMOOTHINGMODE_HIGHQUALITY)
	_GDIPlus_GraphicsClear($hGfx_Buffer, 0xFF000000)

	Local $hBrush = _GDIPlus_BrushCreateSolid(0xFFAA00FF)
	Local $hPen = _GDIPlus_PenCreate(0xFFFFBB00, 2)

	Local $hPath = _GDIPlus_PathCreate()
	Local $hFormat = _GDIPlus_StringFormatCreate()
	_GDIPlus_StringFormatSetAlign($hFormat, 1)
	Local $hFamily = _GDIPlus_FontFamilyCreate("Arial")
	Local $tLayout = _GDIPlus_RectFCreate(0, 0, 600, 300)
	_GDIPlus_PathAddString($hPath, "AutoIt rulez!", $tLayout, $hFamily, 0, 112, $hFormat)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_FontFamilyDispose($hFamily)

	Local $hIter = _GDIPlus_PathIterCreate($hPath)
	Local $hSubPath = _GDIPlus_PathCreate();Path to get the subpath figure

	Local $iPointCount
	While 1
		_GDIPlus_PathReset($hSubPath)

		;e.g. The letter A is composed of two sub-paths - compare with _GDIPlus_PathIterNextSubpathPath
		$iPointCount = _GDIPlus_PathIterNextMarkerPath($hIter, $hSubPath)
		If $iPointCount <= 0 Then ExitLoop ;No more figures

		_GDIPlus_PenSetColor($hPen, BitOR(0xFF000000, Random(0xFF, 0xFFFFFF, 1)))
		_GDIPlus_BrushSetSolidColor($hBrush, BitOR(0xFF000000, Random(0xFF, 0xFFFFFF, 1)))

		_GDIPlus_GraphicsFillPath($hGfx_Buffer, $hSubPath, $hBrush)
		_GDIPlus_GraphicsDrawPath($hGfx_Buffer, $hSubPath, $hPen)
	WEnd

	_GDIPlus_GraphicsDrawImage($hGraphics, $hBmp_Buffer, 0, 0)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_PathDispose($hSubPath)
	_GDIPlus_PathIterDispose($hIter)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGfx_Buffer)
	_GDIPlus_BitmapDispose($hBmp_Buffer)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
