#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	_GDIPlus_Startup()
	Local Const $iW = 120, $iH = 80

	Local $hGui = GUICreate("", $iW, $iH)
	GUISetState()
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGui)

	Local $tPixel = DllStructCreate("uint[" & $iW * $iH & "];")
	Local $iOffset
	For $y = 0 To $iH - 1
		$iOffset = $y * $iW
		For $x = 0 To $iW - 1
			DllStructSetData($tPixel, 1, BitOR(0xFF000000, BitShift(Random(0, 255, 1), -16), BitShift(Random(0, 255, 1), -8), Random(0, 255, 1)), $iOffset + $x + 1)
		Next
	Next

	Local $hBitmap = _GDIPlus_BitmapCreateFromScan0($iW, $iH, $GDIP_PXF32ARGB, $iW, $tPixel)
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0)

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

			Case $GUI_EVENT_RESTORE
				; to redraw the Bitmap
				_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0)
		EndSwitch
	WEnd

	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
