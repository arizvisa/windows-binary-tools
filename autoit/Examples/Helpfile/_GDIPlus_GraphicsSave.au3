#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $iW, $iH, $hGUI, $hGraphic, $hBrush, $hPen, $hPath, $hFormat, $hFamily, $tLayout, $fSize, $iGfx_Save

	$iW = 800
	$iH = 300
	$hGUI = GUICreate("GDI+", $iW, $iH)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	$hPath = _GDIPlus_PathCreate(1)
	For $i = 1 To 200
		$fSize = Random(10, 30)
		_GDIPlus_PathAddEllipse($hPath, Random(0, $iW), Random(0, $iH), $fSize, $fSize)
	Next

	_GDIPlus_GraphicsSetClipPath($hGraphic, $hPath) ;set clipping region
	$iGfx_Save = _GDIPlus_GraphicsSave($hGraphic) ;save clipping region

	_GDIPlus_PathReset($hPath)
	$hFormat = _GDIPlus_StringFormatCreate()
	_GDIPlus_StringFormatSetAlign($hFormat, 1)
	_GDIPlus_StringFormatSetLineAlign($hFormat, 1)
	$hFamily = _GDIPlus_FontFamilyCreate("Arial Black")
	$tLayout = _GDIPlus_RectFCreate(0, 0, $iW, $iH)
	_GDIPlus_PathAddString($hPath, "AutoIt", $tLayout, $hFamily, 1, 200, $hFormat)

	_GDIPlus_GraphicsSetClipPath($hGraphic, $hPath, 3) ;update clipping region

	$hBrush = _GDIPlus_BrushCreateSolid(0xFF7F00FF)
	_GDIPlus_GraphicsFillPath($hGraphic, $hPath, $hBrush)

	_GDIPlus_GraphicsRestore($hGraphic, $iGfx_Save);restore clipping region

	$hPen = _GDIPlus_PenCreate(0xFFFF007F)
	_GDIPlus_GraphicsDrawPath($hGraphic, $hPath, $hPen)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
