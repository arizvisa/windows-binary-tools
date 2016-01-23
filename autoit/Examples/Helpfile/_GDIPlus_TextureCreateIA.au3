#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <Screencapture.au3>

Global $g_hHBitmap, $g_hGfxCtxt, $g_hBMP, $g_hGfx
Global $g_iTiles = 24, $g_a_hBmp_Tiles[$g_iTiles][$g_iTiles]

Example()

Func Example()
	AutoItSetOption("GUIOnEventMode", 1)

	Local $iW = 576, $iH = 576, $iTMP, $iSin = 0, $iMulti = 256 / $g_iTiles, $2Multi = 2 * $iMulti, _
			$hCtxt, $hTextureIA, $fValue, $iFrameTimer = TimerInit()

	_GDIPlus_Startup()
	$g_hHBitmap = _ScreenCapture_Capture("", 0, 0, $g_iTiles ^ 2, $g_iTiles ^ 2) ;capture the desktop and save it in memory in GDI format
	Local $hImage = _GDIPlus_BitmapCreateFromHBITMAP($g_hHBitmap) ;convert the GDI bitmap to GDI+ bitmap
	; Local $iImgW = _GDIPlus_ImageGetWidth($hImage) ;get the width of the image
	; Local $iImgH = _GDIPlus_ImageGetHeight($hImage) ;get the height of the image

	Local $hGUI = GUICreate("GDI+ TextureIA", $iW, $iH) ;create a GUI
	$g_hGfx = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;create a graphic object for displaying GDI+ graphics
	$g_hBMP = _GDIPlus_BitmapCreateFromGraphics($iW, $iH, $g_hGfx) ;create a bitmap object based on a graphic object
	$g_hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($g_hBMP) ;get the graphics context of the image / bitmap

	Local $hBitmap = _GDIPlus_BitmapCreateFromScan0($g_iTiles ^ 2, $g_iTiles ^ 2) ;create an empty bitmap (needed later for texture creating)
	Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap) ;get the graphic context of the image / bitmap
	_GDIPlus_GraphicsDrawImageRect($hContext, $hImage, 0, 0, $g_iTiles ^ 2, $g_iTiles ^ 2) ;copy the image into the empty bitmap
	_GDIPlus_GraphicsDispose($hContext) ;release graphic context handle
	_GDIPlus_ImageDispose($hImage) ;release image handle

	Local $tCM = _GDIPlus_ColorMatrixCreateScale(0, 0, 0) ;create and initializes a scaling color matrix (5 x 5 homogeneous matrix for a 4-space transformation) -> see http://msdn.microsoft.com/en-us/library/windows/desktop/ms533875(v=vs.85).aspx
	Local $pImgAttr = _GDIPlus_ImageAttributesCreate() ;create an image attribute object (needed for color manipulation)
	Local $fSizeInv = 1 / $g_iTiles

	;create $g_iTiles * $g_iTiles small bitmaps (tiles) to fill it up with parts of the captured image
	For $iY = 0 To $g_iTiles - 1
		For $iX = 0 To $g_iTiles - 1
			$g_a_hBmp_Tiles[$iY][$iX] = _GDIPlus_BitmapCreateFromScan0($g_iTiles, $g_iTiles) ;create an empty bitmap
			$hCtxt = _GDIPlus_ImageGetGraphicsContext($g_a_hBmp_Tiles[$iY][$iX]) ;get the graphics context of the image / bitmap
			$fValue = BitXOR($iX, $iY) * $fSizeInv
			$tCM.m(1) = 1 - $fValue ; red
			$tCM.m(7) = $fValue ;green
			$tCM.m(19) = 0.4 ;alpha
			_GDIPlus_ImageAttributesSetColorMatrix($pImgAttr, 0, True, $tCM) ;adjust the ImageAttribute color matrix for each bitmap
			$hTextureIA = _GDIPlus_TextureCreateIA($hBitmap, $iX * $g_iTiles, $iY * $g_iTiles, $g_iTiles, $g_iTiles, $pImgAttr) ;creates a texture brush object based on an image with changed image attributes
			_GDIPlus_GraphicsFillRect($hCtxt, 0, 0, $g_iTiles, $g_iTiles, $hTextureIA) ;draw rectangle filled with manipulated tile of the image to the bitmap
			_GDIPlus_GraphicsDispose($hCtxt) ;release graphic context handle
			_GDIPlus_BrushDispose($hTextureIA) ;release texture
		Next
	Next
	_GDIPlus_ImageAttributesDispose($pImgAttr) ;releases the image attributes object

	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit", $hGUI)
	GUISetState(@SW_SHOW, $hGUI)

	While Sleep(10)
		$iSin += 25 / (1000 / TimerDiff($iFrameTimer))
		_GDIPlus_GraphicsClear($g_hGfxCtxt, 0xB0808080) ;Clears a graphic object to a specified color
		For $iX = 0 To $g_iTiles - 1
			$iTMP = 2 * $iX * $iMulti
			For $iY = 0 To $g_iTiles - 1
				;move each tile to its new position
				_GDIPlus_GraphicsDrawImageRect($g_hGfxCtxt, $g_a_hBmp_Tiles[$iY][$iX], _ ;bitmap handle
						25 + 15 * Sin($iY * $iMulti / 64 + $iSin) + $iTMP, _ ;x pos
						15 * Cos($iX * $iMulti / 64 + $iSin) + 25 + $iY * $2Multi, _ ;y pos
						$2Multi, _ ;width
						$2Multi) ;height
			Next
		Next
		_GDIPlus_GraphicsDrawImage($g_hGfx, $g_hBMP, 0, 0) ;draw complete drawn image into GUI
		$iFrameTimer = TimerInit()
	WEnd
EndFunc   ;==>Example

Func _Exit() ;clean up resources
	_WinAPI_DeleteObject($g_hHBitmap)
	_GDIPlus_GraphicsDispose($g_hGfxCtxt)
	_GDIPlus_BitmapDispose($g_hBMP)
	_GDIPlus_GraphicsDispose($g_hGfx)
	For $iY = 0 To $g_iTiles - 1
		For $iX = 0 To $g_iTiles - 1
			_GDIPlus_BitmapDispose($g_a_hBmp_Tiles[$iY][$iX])
		Next
	Next
	_GDIPlus_Shutdown()
	Exit
EndFunc   ;==>_Exit
