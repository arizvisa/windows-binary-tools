#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	; Create GUI
	Local $hGUI = GUICreate("GDI+", 800, 340)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	Local $hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	Local $hPen = _GDIPlus_PenCreate(0xFF0000FF)
	Local $hBrush = _GDIPlus_BrushCreateSolid(0xFFFF0000)

	Local $hFormat = _GDIPlus_StringFormatCreate()
	Local $hFamily = _GDIPlus_FontFamilyCreate("Arial")
	Local $hFont = _GDIPlus_FontCreate($hFamily, 96, 0)

	Local $sString = ChrW(0x1EF2) & ChrW(0x1EF3)

	Local $iPosX = 50
	Local $iPosY = 50
	Local $aStrDim = _MeasureString($hGraphic, $sString, $hFont, $hFormat, $hFamily)

	_GDIPlus_GraphicsDrawString($hGraphic, "MeasureString", $iPosX, $iPosY - 30)
	_GDIPlus_GraphicsDrawLine($hGraphic, $iPosX, $iPosY - 5, $iPosX, $iPosY + 5, $hPen)
	_GDIPlus_GraphicsDrawLine($hGraphic, $iPosX - 5, $iPosY, $iPosX + 5, $iPosY, $hPen)
	Local $tLayout = _GDIPlus_RectFCreate($iPosX, $iPosY, $aStrDim[4], $aStrDim[5])
	_GDIPlus_GraphicsDrawRect($hGraphic, $iPosX, $iPosY, $aStrDim[4], $aStrDim[5], $hPen)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, $sString, $hFont, $tLayout, $hFormat, $hBrush)

	$iPosX = 300
	_GDIPlus_GraphicsDrawString($hGraphic, "MeasureCharacterRanges", $iPosX, $iPosY - 30)
	_GDIPlus_GraphicsDrawLine($hGraphic, $iPosX, $iPosY - 5, $iPosX, $iPosY + 5, $hPen)
	_GDIPlus_GraphicsDrawLine($hGraphic, $iPosX - 5, $iPosY, $iPosX + 5, $iPosY, $hPen)
	_GDIPlus_GraphicsDrawRect($hGraphic, $iPosX + $aStrDim[0], $iPosY + $aStrDim[1], $aStrDim[2], $aStrDim[3], $hPen)
	DllStructSetData($tLayout, "X", $iPosX)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, $sString, $hFont, $tLayout, $hFormat, $hBrush)

	$iPosX = 550
	_GDIPlus_GraphicsDrawString($hGraphic, "CellAscent / CellDescent", $iPosX, $iPosY - 30)
	_GDIPlus_GraphicsDrawLine($hGraphic, $iPosX, $iPosY - 5, $iPosX, $iPosY + 5, $hPen)
	_GDIPlus_GraphicsDrawLine($hGraphic, $iPosX - 5, $iPosY, $iPosX + 5, $iPosY, $hPen)
	_GDIPlus_GraphicsDrawRect($hGraphic, $iPosX + $aStrDim[0], $iPosY + $aStrDim[1], $aStrDim[2], $aStrDim[7], $hPen)
	_GDIPlus_GraphicsDrawRect($hGraphic, $iPosX + $aStrDim[0], $iPosY + $aStrDim[1] + $aStrDim[7], $aStrDim[2], $aStrDim[8], $hPen)
	DllStructSetData($tLayout, "X", $iPosX)
	_GDIPlus_GraphicsDrawStringEx($hGraphic, $sString, $hFont, $tLayout, $hFormat, $hBrush)

	$sString = "fontsize goes crazy"
	$iPosX = 50
	$iPosY = 300

	Local $sChar
	For $i = 0 To StringLen($sString)

		$sChar = StringLeft($sString, 1)
		$sString = StringTrimLeft($sString, 1)

		If $sChar = " " Then
			$aStrDim = _MeasureString($hGraphic, "_", $hFont, $hFormat, $hFamily)
			$iPosX += $aStrDim[2]
			ContinueLoop
		EndIf

		_GDIPlus_FontDispose($hFont)
		$hFont = _GDIPlus_FontCreate($hFamily, Random(12, 48), 0)
		$aStrDim = _MeasureString($hGraphic, $sChar, $hFont, $hFormat, $hFamily)

		$tLayout = _GDIPlus_RectFCreate($iPosX - $aStrDim[0], $iPosY - $aStrDim[1] - $aStrDim[7], $aStrDim[4], $aStrDim[5])
		_GDIPlus_GraphicsDrawStringEx($hGraphic, $sChar, $hFont, $tLayout, $hFormat, $hBrush)

		$iPosX += $aStrDim[2]
	Next

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_FontDispose($hFont)
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example

Func _MeasureString($hGraphics, $sString, $hFont, $hFormat, $hFamily, $iStyle = 0)
	Local $tLayout = _GDIPlus_RectFCreate()
	Local $aInfo = _GDIPlus_GraphicsMeasureString($hGraphics, $sString, $hFont, $tLayout, $hFormat)

	Local $aRanges[2][2] = [[1]]
	$aRanges[1][1] = StringLen($sString)
	_GDIPlus_StringFormatSetMeasurableCharacterRanges($hFormat, $aRanges)
	Local $aRegion = _GDIPlus_GraphicsMeasureCharacterRanges($hGraphics, $sString, $hFont, $aInfo[0], $hFormat)
	Local $aBounds = _GDIPlus_RegionGetBounds($aRegion[1], $hGraphics)
	_GDIPlus_RegionDispose($aRegion[1])

	Local $iFontHeight = _GDIPlus_FontGetHeight($hFont, $hGraphics)
	Local $iLineSpacing = _GDIPlus_FontFamilyGetLineSpacing($hFamily, $iStyle)
	Local $iAscent = $iFontHeight / $iLineSpacing * _GDIPlus_FontFamilyGetCellAscent($hFamily, $iStyle)
	Local $iDescent = $iFontHeight / $iLineSpacing * _GDIPlus_FontFamilyGetCellDescent($hFamily, $iStyle)

	Local $aDim[9]
	$aDim[0] = $aBounds[0]
	$aDim[1] = $aBounds[1]
	$aDim[2] = $aBounds[2]
	$aDim[3] = $aBounds[3]
	$aDim[4] = DllStructGetData($aInfo[0], "Width")
	$aDim[5] = DllStructGetData($aInfo[0], "Height")
	$aDim[6] = $iFontHeight
	$aDim[7] = $iAscent
	$aDim[8] = $iDescent

	Return $aDim
EndFunc   ;==>_MeasureString
