#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>

Example()

Func Example()
	Local $hBMP = _ScreenCapture_Capture()

	Local $hGUI = GUICreate("GDI+", 400, 400)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	Local $hBmp_Buffer = _GDIPlus_BitmapCreateFromGraphics(400, 400, $hGraphics)
	Local $hGfx_Buffer = _GDIPlus_ImageGetGraphicsContext($hBmp_Buffer)

	Local $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBMP)

	Local $hMatrix1 = _GDIPlus_MatrixCreate()
	_GDIPlus_MatrixTranslate($hMatrix1, 200, 200)
	Local $hMatrix2 = _GDIPlus_MatrixCreate()
	_GDIPlus_MatrixTranslate($hMatrix2, 200, 200)

	Local $hPath = _GDIPlus_PathCreate()
	For $i = 0 To 300 Step 24
		_GDIPlus_PathAddEllipse($hPath, -$i, -$i, $i * 2, $i * 2)
	Next

	Local $hRegion = _GDIPlus_RegionCreate()
	_GDIPlus_RegionCombinePath($hRegion, $hPath, 4)

	Local $hTimer = TimerInit()
	; Loop until the user exits.
	Do
		If TimerDiff($hTimer) > 20 Then
			_GDIPlus_GraphicsResetClip($hGfx_Buffer)
			_GDIPlus_GraphicsClear($hGfx_Buffer, 0x33FFAA00)

			_GDIPlus_MatrixRotate($hMatrix1, 1)
			_GDIPlus_MatrixRotate($hMatrix2, -1)

			_GDIPlus_GraphicsSetTransform($hGfx_Buffer, $hMatrix1)
			_GDIPlus_GraphicsSetClipRegion($hGfx_Buffer, $hRegion)
			_GDIPlus_GraphicsDrawImage($hGfx_Buffer, $hBitmap, -300, -300)

			_GDIPlus_GraphicsSetTransform($hGfx_Buffer, $hMatrix2)
			_GDIPlus_GraphicsSetClipPath($hGfx_Buffer, $hPath)
			_GDIPlus_GraphicsDrawImage($hGfx_Buffer, $hBitmap, -300, -300)

			_GDIPlus_GraphicsDrawImage($hGraphics, $hBmp_Buffer, 0, 0)
			$hTimer = TimerInit()
		EndIf
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_RegionDispose($hRegion)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_MatrixDispose($hMatrix1)
	_GDIPlus_MatrixDispose($hMatrix2)
	_GDIPlus_BitmapDispose($hBitmap)
	_WinAPI_DeleteObject($hBMP)
	_GDIPlus_GraphicsDispose($hGfx_Buffer)
	_GDIPlus_BitmapDispose($hBmp_Buffer)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
