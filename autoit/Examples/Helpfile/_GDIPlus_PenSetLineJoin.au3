#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI = GUICreate("GDI+", 800, 400)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	Local $hBmp_Buffer = _GDIPlus_BitmapCreateFromGraphics(800, 400, $hGraphics)
	Local $hGfx_Buffer = _GDIPlus_ImageGetGraphicsContext($hBmp_Buffer)
	_GDIPlus_GraphicsSetSmoothingMode($hGfx_Buffer, $GDIP_SMOOTHINGMODE_HIGHQUALITY)
	_GDIPlus_GraphicsClear($hGfx_Buffer, 0xFF000000)

	Local $hPath = _GDIPlus_PathCreate()
	Local $hFormat = _GDIPlus_StringFormatCreate()
	_GDIPlus_StringFormatSetAlign($hFormat, 1)
	Local $hFamily = _GDIPlus_FontFamilyCreate("Arial")
	Local $tLayout = _GDIPlus_RectFCreate(0, 0, 800, 400)
	_GDIPlus_PathAddString($hPath, "AutoIt rulez!", $tLayout, $hFamily, 0, 140, $hFormat)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_FontFamilyDispose($hFamily)

	Local $aPoints[5][2] = [[4]]
	$aPoints[1][0] = 0
	$aPoints[1][1] = 0
	$aPoints[2][0] = 20
	$aPoints[2][1] = 0
	$aPoints[3][0] = 20
	$aPoints[3][1] = 20
	$aPoints[4][0] = 0
	$aPoints[4][1] = 20

	Local $aColors[4] = [3]
	$aColors[1] = 0xFFFF0000
	$aColors[2] = 0xFF00FF00
	$aColors[3] = 0xFF0000FF

	Local $hMatrix = _GDIPlus_MatrixCreate()
	_GDIPlus_MatrixRotate($hMatrix, 1, True)

	Local $hBrush, $hPen

	Local $hTimer = TimerInit()
	; Loop until the user exits.
	Do
		If TimerDiff($hTimer) > 40 Then
			_GDIPlus_MatrixTransformPoints($hMatrix, $aPoints)

			$hBrush = _GDIPlus_PathBrushCreate($aPoints, 3)
			_GDIPlus_PathBrushSetCenterColor($hBrush, 0xFFFFFFFF)
			_GDIPlus_PathBrushSetSurroundColorsWithCount($hBrush, $aColors)
			$hPen = _GDIPlus_PenCreate2($hBrush, 6)
			_GDIPlus_PenSetLineJoin($hPen, $GDIP_PENSETLINEJOIN_ROUND)
			_GDIPlus_BrushDispose($hBrush)

			_GDIPlus_GraphicsClear($hGfx_Buffer, 0xFF000000)
			_GDIPlus_GraphicsDrawPath($hGfx_Buffer, $hPath, $hPen)
			_GDIPlus_PenDispose($hPen)

			_GDIPlus_GraphicsDrawImage($hGraphics, $hBmp_Buffer, 0, 0)
			$hTimer = TimerInit()
		EndIf
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_MatrixDispose($hMatrix)
	_GDIPlus_GraphicsDispose($hGfx_Buffer)
	_GDIPlus_BitmapDispose($hBmp_Buffer)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
