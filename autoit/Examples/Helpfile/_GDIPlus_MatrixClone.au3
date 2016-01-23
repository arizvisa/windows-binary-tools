#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hPen, $hPath, $hMatrix_Scale, $hMatrix_Clone, $hMatrix_Rotate

	; Create GUI
	$hGUI = GUICreate("GDI+", 600, 600)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;Sets the graphics object rendering quality (antialiasing)
	_GDIPlus_GraphicsClear($hGraphic, 0xFF000000)

	$hPen = _GDIPlus_PenCreate(0xFFFFBB00, 2)

	$hPath = _GDIPlus_PathCreate()
	_GDIPlus_PathAddArc($hPath, 0, 0, 600, 600, 0, 45)

	$hMatrix_Scale = _GDIPlus_MatrixCreate()
	_GDIPlus_MatrixTranslate($hMatrix_Scale, -300, -300)
	_GDIPlus_MatrixScale($hMatrix_Scale, 0.9, 0.9, True)

	$hMatrix_Rotate = _GDIPlus_MatrixCreate()
	_GDIPlus_MatrixRotate($hMatrix_Rotate, 40, True)

	For $i = 1 To 32
		$hMatrix_Clone = _GDIPlus_MatrixClone($hMatrix_Scale)
		_GDIPlus_MatrixMultiply($hMatrix_Clone, $hMatrix_Rotate, 1)
		_GDIPlus_MatrixTranslate($hMatrix_Clone, 300, 300, True)

		_GDIPlus_PathTransform($hPath, $hMatrix_Clone)
		_GDIPlus_MatrixDispose($hMatrix_Clone)

		_GDIPlus_GraphicsDrawPath($hGraphic, $hPath, $hPen)
	Next

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_MatrixDispose($hMatrix_Rotate)
	_GDIPlus_MatrixDispose($hMatrix_Scale)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
