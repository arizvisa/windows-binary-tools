#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hBrush, $hMatrix

	$hGUI = GUICreate("GDI+", 420, 420)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	$hBrush = _GDIPlus_LineBrushCreate(10, 10, 410, 410, 0xFF000000, 0xFFFFFFFF, 3)
	_GDIPlus_LineBrushSetSigmaBlend($hBrush, 1)

	$hMatrix = _GDIPlus_MatrixCreate()
	_GDIPlus_MatrixTranslate($hMatrix, -210, -210)
	_GDIPlus_MatrixRotate($hMatrix, 1, True)
	_GDIPlus_MatrixTranslate($hMatrix, 210, 210, True)

	For $i = 1 To 360
		_GDIPlus_GraphicsFillRect($hGraphic, 10, 10, 400, 400, $hBrush)
		_GDIPlus_LineBrushMultiplyTransform($hBrush, $hMatrix, True)
		Sleep(10)
	Next

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_MatrixDispose($hMatrix)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
