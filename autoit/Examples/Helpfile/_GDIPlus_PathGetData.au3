#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $iW, $iH, $hGUI, $hGraphic, $hBrush, $hPen, $hPath, $hPath_Clone, $hFamily, $tLayout
	Local $aBounds, $aPathData1, $aPathData2

	$iW = 800
	$iH = 300
	$hGUI = GUICreate("GDI+", $iW, $iH)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, $GDIP_SMOOTHINGMODE_HIGHQUALITY)
	_GDIPlus_GraphicsClear($hGraphic, 0xFF000000)

	$hBrush = _GDIPlus_BrushCreateSolid(0xFF006600)
	$hPen = _GDIPlus_PenCreate(0xFF00FF00, 2)

	$hPath = _GDIPlus_PathCreate()

	$hFamily = _GDIPlus_FontFamilyCreate("Arial Black")
	$tLayout = _GDIPlus_RectFCreate()
	_GDIPlus_PathAddString($hPath, "AutoIt", $tLayout, $hFamily)
	_GDIPlus_PathFlatten($hPath, 0.01)

	$aBounds = _GDIPlus_PathGetWorldBounds($hPath)
	$hPath_Clone = _GDIPlus_PathClone($hPath)

	Local $aPoints[5][2]
	$aPoints[0][0] = 4
	$aPoints[1][0] = $iW * 0.2
	$aPoints[1][1] = $iH * 0.3
	$aPoints[2][0] = $iW * 0.8
	$aPoints[2][1] = $iH * 0.3
	$aPoints[3][0] = 0
	$aPoints[3][1] = $iH
	$aPoints[4][0] = $iW
	$aPoints[4][1] = $iH

	_GDIPlus_PathWarp($hPath, 0, $aPoints, $aBounds[0], $aBounds[1], $aBounds[2], $aBounds[3] + 2)

	$aPoints[1][1] -= 12
	$aPoints[2][1] -= 12
	$aPoints[3][1] -= 32
	$aPoints[4][1] -= 32

	_GDIPlus_PathWarp($hPath_Clone, 0, $aPoints, $aBounds[0], $aBounds[1], $aBounds[2], $aBounds[3] + 2)

	_GDIPlus_GraphicsFillPath($hGraphic, $hPath, $hBrush)

	$aPathData1 = _GDIPlus_PathGetData($hPath)
	$aPathData2 = _GDIPlus_PathGetData($hPath_Clone)

	Local $aPolyGon[5][2] = [[4]], $iIdx
	For $i = 1 To $aPathData1[0][0]
		If $aPathData1[$i][2] = 0 Then $iIdx = $i

		$aPolyGon[1][0] = $aPathData1[$i][0]
		$aPolyGon[1][1] = $aPathData1[$i][1]
		$aPolyGon[4][0] = $aPathData2[$i][0]
		$aPolyGon[4][1] = $aPathData2[$i][1]

		If BitAND($aPathData1[$i][2], 0x80) Then
			$aPolyGon[2][0] = $aPathData1[$iIdx][0]
			$aPolyGon[2][1] = $aPathData1[$iIdx][1]
			$aPolyGon[3][0] = $aPathData2[$iIdx][0]
			$aPolyGon[3][1] = $aPathData2[$iIdx][1]
		Else
			$aPolyGon[2][0] = $aPathData1[$i + 1][0]
			$aPolyGon[2][1] = $aPathData1[$i + 1][1]
			$aPolyGon[3][0] = $aPathData2[$i + 1][0]
			$aPolyGon[3][1] = $aPathData2[$i + 1][1]
		EndIf

		_GDIPlus_GraphicsFillPolygon($hGraphic, $aPolyGon, $hBrush)
	Next

	_GDIPlus_BrushSetSolidColor($hBrush, 0xFF00AA00)
	_GDIPlus_GraphicsFillPath($hGraphic, $hPath_Clone, $hBrush)
	_GDIPlus_GraphicsDrawPath($hGraphic, $hPath_Clone, $hPen)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_PathDispose($hPath_Clone)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
