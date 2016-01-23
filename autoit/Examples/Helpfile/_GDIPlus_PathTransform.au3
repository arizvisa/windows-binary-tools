#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $iW, $iH, $hGUI, $hGraphic, $hBrush, $hPen, $hPath, $hFamily, $tLayout, $hMatrix, $aBounds

	; Create GUI
	$iW = 640
	$iH = 220
	$hGUI = GUICreate("GDI+", $iW, $iH)
	GUISetState(@SW_SHOW)

	; Draw a string using path
	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;Sets the graphics object rendering quality (antialiasing)
	_GDIPlus_GraphicsClear($hGraphic, 0xFF000000)

	$hBrush = _GDIPlus_BrushCreateSolid(0xFFDD2200)
	$hPen = _GDIPlus_PenCreate(0xFFFFBB00, 2)

	$hPath = _GDIPlus_PathCreate() ;Create new path object

	$hFamily = _GDIPlus_FontFamilyCreate("Arial") ;Create font family object
	$tLayout = _GDIPlus_RectFCreate() ;Create string bounding rectangle X=0, Y=0
	_GDIPlus_PathAddString($hPath, "Fit to Window", $tLayout, $hFamily) ;Add the outline of the string to the path

	; Tranform Path to fit to window
	$aBounds = _GDIPlus_PathGetWorldBounds($hPath) ;Get bounding rectangle of the path
	$hMatrix = _GDIPlus_MatrixCreate()
	_GDIPlus_MatrixTranslate($hMatrix, -$aBounds[0], -$aBounds[1]) ;Translate Matrix to the offset of the bounding rectangle
	_GDIPlus_MatrixScale($hMatrix, $iW / $aBounds[2], $iH / $aBounds[3], True) ;Scale Matrix
	_GDIPlus_PathTransform($hPath, $hMatrix) ;Translate and Scale Path

	_GDIPlus_GraphicsFillPath($hGraphic, $hPath, $hBrush) ;Fill path to graphics handle (GUI)
	_GDIPlus_GraphicsDrawPath($hGraphic, $hPath, $hPen) ;Draw path to graphics handle (GUI)

	; Tranform Path to center the path
	_GDIPlus_PathReset($hPath) ;Reset Path (delete previous string)
	_GDIPlus_PathAddString($hPath, "Center", $tLayout, $hFamily, 0, 100, 0) ;Add the outline of the string to the path

	$aBounds = _GDIPlus_PathGetWorldBounds($hPath)
	_GDIPlus_MatrixSetElements($hMatrix, 1, 0, 0, 1, 0, 0) ;Reset Matrix
	_GDIPlus_MatrixTranslate($hMatrix, ($iW / 2) - $aBounds[0] - ($aBounds[2] / 2), ($iH / 2) - $aBounds[1] - ($aBounds[3] / 2))
	_GDIPlus_PathTransform($hPath, $hMatrix) ;Translate (offset) Path

	_GDIPlus_BrushSetSolidColor($hBrush, 0x7F004488)
	_GDIPlus_PenSetColor($hPen, 0xFF00AAFF)
	_GDIPlus_GraphicsFillPath($hGraphic, $hPath, $hBrush) ;Fill path to graphics handle (GUI)
	_GDIPlus_GraphicsDrawPath($hGraphic, $hPath, $hPen) ;Draw path to graphics handle (GUI)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_MatrixDispose($hMatrix)
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
