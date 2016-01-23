#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	; Create GUI
	Local $hGUI = GUICreate("GDI+", 640, 220)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	Local $hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	Local $hPen = _GDIPlus_PenCreate(0xFF006600)
	Local $hBrush_Region = _GDIPlus_BrushCreateSolid(0x44FF0000)
	Local $hBrush_Font = _GDIPlus_BrushCreateSolid(0xFFFF0000)

	Local $hFormat = _GDIPlus_StringFormatCreate()
	Local $hFamily = _GDIPlus_FontFamilyCreate("Arial")

	Local $sString = "Measure Character Ranges"

	Local $aRanges[4][2] = [[3]]
	$aRanges[1][0] = 0 ;Measure first char (0-ased)
	$aRanges[1][1] = 1 ;One char to measure
	$aRanges[2][0] = 4 ;5th char
	$aRanges[2][1] = 5 ;measure 5 chars
	$aRanges[3][0] = 14 ;15th char
	$aRanges[3][1] = 7 ;measure 7 chars

	_GDIPlus_StringFormatSetMeasurableCharacterRanges($hFormat, $aRanges) ;Set ranges

	;Measure characters fontsize = 14
	Local $hFont = _GDIPlus_FontCreate($hFamily, 14, 0)
	Local $tLayout = _GDIPlus_RectFCreate(10, 10, 200, 200)
	_GDIPlus_GraphicsDrawRect($hGraphic, 10, 10, 200, 200, $hPen)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, $sString, $hFont, $tLayout, $hFormat, $hBrush_Font)
	Local $aRegions = _GDIPlus_GraphicsMeasureCharacterRanges($hGraphic, $sString, $hFont, $tLayout, $hFormat) ;get array of regions
	For $i = 1 To $aRegions[0]
		_GDIPlus_GraphicsFillRegion($hGraphic, $aRegions[$i], $hBrush_Region)
		_GDIPlus_RegionDispose($aRegions[$i])
	Next
	_GDIPlus_FontDispose($hFont)

	;Measure characters fontsize = 28
	$hFont = _GDIPlus_FontCreate($hFamily, 28, 0)
	$tLayout = _GDIPlus_RectFCreate(220, 10, 200, 200)
	_GDIPlus_GraphicsDrawRect($hGraphic, 220, 10, 200, 200, $hPen)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, $sString, $hFont, $tLayout, $hFormat, $hBrush_Font)
	$aRegions = _GDIPlus_GraphicsMeasureCharacterRanges($hGraphic, $sString, $hFont, $tLayout, $hFormat)
	For $i = 1 To $aRegions[0]
		_GDIPlus_GraphicsFillRegion($hGraphic, $aRegions[$i], $hBrush_Region)
		_GDIPlus_RegionDispose($aRegions[$i])
	Next
	_GDIPlus_FontDispose($hFont)

	;Measure characters fontsize = 56
	$hFont = _GDIPlus_FontCreate($hFamily, 56, 0)
	$tLayout = _GDIPlus_RectFCreate(430, 10, 200, 200)
	_GDIPlus_GraphicsDrawRect($hGraphic, 430, 10, 200, 200, $hPen)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, $sString, $hFont, $tLayout, $hFormat, $hBrush_Font)
	$aRegions = _GDIPlus_GraphicsMeasureCharacterRanges($hGraphic, $sString, $hFont, $tLayout, $hFormat)
	For $i = 1 To $aRegions[0]
		_GDIPlus_GraphicsFillRegion($hGraphic, $aRegions[$i], $hBrush_Region)
		_GDIPlus_RegionDispose($aRegions[$i])
	Next
	_GDIPlus_FontDispose($hFont)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_BrushDispose($hBrush_Font)
	_GDIPlus_BrushDispose($hBrush_Region)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
