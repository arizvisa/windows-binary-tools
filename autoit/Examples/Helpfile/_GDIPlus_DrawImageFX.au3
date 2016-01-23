#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

_Example()

Func _Example()
	If Not _GDIPlus_Startup() Or @extended < 6 Then
		MsgBox($MB_SYSTEMMODAL, "ERROR", "GDIPlus.dll v1.1 not available")
		Return
	EndIf

	Local $sFile = FileOpenDialog("Select an image", "", "Images (*.bmp;*.png;*.jpg;*.gif;*.tif)")
	If @error Or Not FileExists($sFile) Then Return

	Local $hImage = _GDIPlus_ImageLoadFromFile($sFile)
	Local $iImgW = _GDIPlus_ImageGetWidth($hImage)
	Local $iImgH = _GDIPlus_ImageGetHeight($hImage)

	Local $iWidth = 600
	Local $iHeight = $iImgH * 600 / $iImgW

	Local $hBitmap = _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight)
	Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsDrawImageRect($hContext, $hImage, 0, 0, $iWidth, $iHeight)

	Local $hGui = GUICreate("GDI+ v1.1 (" & @ScriptName & ")", $iWidth, $iHeight)
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGui)
	GUISetState(@SW_SHOW)

	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0)

	Local $hEffect = _GDIPlus_EffectCreateHueSaturationLightness(-90)
	Local $tRECTF = _GDIPlus_RectFCreate($iWidth * 0.25, $iHeight * 0.25, $iWidth * 0.5, $iHeight * 0.5)
	_GDIPlus_DrawImageFX($hGraphics, $hBitmap, $hEffect, $tRECTF)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	_GDIPlus_GraphicsDispose($hContext)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_EffectDispose($hEffect)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>_Example
