#include <GDIPlus.au3>

Example()

Func Example()
	_GDIPlus_Startup()
	Local Const $iW = 460, $iH = 100
	Local $hBitmap = _GDIPlus_BitmapCreateFromScan0($iW, $iH) ;create an empty bitmap
	Local $hBmpCtxt = _GDIPlus_ImageGetGraphicsContext($hBitmap) ;get the graphics context of the bitmap
	_GDIPlus_GraphicsSetSmoothingMode($hBmpCtxt, $GDIP_SMOOTHINGMODE_HIGHQUALITY)
	_GDIPlus_GraphicsClear($hBmpCtxt, 0xFFFFFFFF) ;clear bitmap with color white
	_GDIPlus_GraphicsDrawString($hBmpCtxt, "AutoIt rulez!", 0, 0, "Comic Sans MS", 52) ;draw some text to the bitmap
	Local $sFile = @TempDir & "\Test.jpg"
	_GDIPlus_ImageSaveToFile($hBitmap, $sFile) ;save bitmap to disk
	;cleanup GDI+ resources
	_GDIPlus_GraphicsDispose($hBmpCtxt)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_Shutdown()
	ShellExecute($sFile) ;open bitmap with default app
EndFunc   ;==>Example
