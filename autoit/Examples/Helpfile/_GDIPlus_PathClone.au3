#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $iW, $iH, $hGUI, $hGraphic, $hBrush, $hPen, $hPath, $hPath_Clone, $hMatrix

	; Create GUI
	$iW = 600
	$iH = 600
	$hGUI = GUICreate("GDI+", $iW, $iH)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;Sets the graphics object rendering quality (antialiasing)
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	$hBrush = _GDIPlus_BrushCreateSolid(0x7F8800AA)
	$hPen = _GDIPlus_PenCreate(0xFF8800AA, 2)

	$hPath = _GDIPlus_PathCreate() ;Create new path object

	;spiral as a sequence of lines
	Local $iXOld = 0, $iYOld = 0, $iX, $iY, $iAngle = 0, $iRadius = 0
	For $i = 0 To 200
		$iX = Cos($iAngle) * $iRadius
		$iY = Sin($iAngle) * $iRadius
		$iAngle += 0.1
		$iRadius = $iAngle ^ 2 / 2
		_GDIPlus_PathAddLine($hPath, $iXOld, $iYOld, $iX, $iY)
		$iXOld = $iX
		$iYOld = $iY
	Next

	$hPath_Clone = _GDIPlus_PathClone($hPath)
	_GDIPlus_PathReverse($hPath_Clone) ;reverse path => end point of path = start point of cloned path

	$hMatrix = _GDIPlus_MatrixCreate()
	_GDIPlus_MatrixScale($hMatrix, 1.5, 1.5)
	_GDIPlus_PathTransform($hPath_Clone, $hMatrix) ;zoom cloned path

	_GDIPlus_PathAddPath($hPath, $hPath_Clone) ;add scaled/reversed path to original path

	_GDIPlus_MatrixSetElements($hMatrix, 1, 0, 0, 1, 0, 0) ;reset matrix
	_GDIPlus_MatrixTranslate($hMatrix, $iW / 2, $iH / 2, True)
	_GDIPlus_PathTransform($hPath, $hMatrix) ;move path to center of window

	_GDIPlus_GraphicsFillPath($hGraphic, $hPath, $hBrush) ;Fill path to graphics handle (GUI)
	_GDIPlus_GraphicsDrawPath($hGraphic, $hPath, $hPen) ;Draw path to graphics handle (GUI)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_MatrixDispose($hMatrix)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_PathDispose($hPath_Clone)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
