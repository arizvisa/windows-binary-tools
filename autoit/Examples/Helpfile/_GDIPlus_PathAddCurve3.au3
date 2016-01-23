#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Global $g_hGUI, $g_hGraphics, $g_hBmp_Buffer, $g_hGfx_Buffer, $g_hPen, $g_hPen2, $g_hPath, $g_hPath2

Example()

Func Example()
	AutoItSetOption("GUIOnEventMode", 1)

	Local Const $iW = 400, $iH = 400

	$g_hGUI = GUICreate("GDI+", $iW, $iH)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$g_hGraphics = _GDIPlus_GraphicsCreateFromHWND($g_hGUI) ;Create a graphics object from a window handle
	$g_hBmp_Buffer = _GDIPlus_BitmapCreateFromGraphics($iW, $iH, $g_hGraphics)
	$g_hGfx_Buffer = _GDIPlus_ImageGetGraphicsContext($g_hBmp_Buffer)
	_GDIPlus_GraphicsSetSmoothingMode($g_hGfx_Buffer, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;Sets the graphics object rendering quality (antialiasing)

	$g_hPen = _GDIPlus_PenCreate(0xFF8800AA, 2)
	$g_hPen2 = _GDIPlus_PenCreate(0xFFFFDD00, 3)

	$g_hPath = _GDIPlus_PathCreate() ;Create new path object

	Local $aPoints[201][2] = [[200]], $iRadius = 0
	For $i = 1 To $aPoints[0][0]
		$aPoints[$i][0] = Cos($i / 3.14) * $iRadius + $iW / 2
		$aPoints[$i][1] = Sin($i / 3.14) * $iRadius + $iH / 2
		$iRadius += 1
	Next

	_GDIPlus_PathAddCurve($g_hPath, $aPoints)

	$g_hPath2 = _GDIPlus_PathCreate() ;Create new path object
	Local $iOff = 1, $iNum = 4
	While Sleep(20)
		_GDIPlus_PathReset($g_hPath2)
		_GDIPlus_PathAddCurve3($g_hPath2, $aPoints, $iOff, $iNum)

		$iOff += 1
		If $iOff > $aPoints[0][0] - $iNum Then $iOff = 1

		_GDIPlus_GraphicsClear($g_hGfx_Buffer, 0xFF000000)
		_GDIPlus_GraphicsDrawPath($g_hGfx_Buffer, $g_hPath, $g_hPen) ;Draw path to graphics handle (GUI)
		_GDIPlus_GraphicsDrawPath($g_hGfx_Buffer, $g_hPath2, $g_hPen2) ;Draw path to graphics handle (GUI)
		_GDIPlus_GraphicsDrawImage($g_hGraphics, $g_hBmp_Buffer, 0, 0)
	WEnd
EndFunc   ;==>Example

Func _Exit()
	; Clean up resources
	_GDIPlus_PathDispose($g_hPath)
	_GDIPlus_PathDispose($g_hPath2)
	_GDIPlus_PenDispose($g_hPen)
	_GDIPlus_PenDispose($g_hPen2)
	_GDIPlus_GraphicsDispose($g_hGfx_Buffer)
	_GDIPlus_BitmapDispose($g_hBmp_Buffer)
	_GDIPlus_GraphicsDispose($g_hGraphics)
	_GDIPlus_Shutdown()
	GUIDelete($g_hGUI)
	Exit
EndFunc   ;==>_Exit
