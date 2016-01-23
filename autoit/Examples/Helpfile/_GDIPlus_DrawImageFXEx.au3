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

	Local $iWidth = 600
	Local $iHeight = _GDIPlus_ImageGetHeight($hImage) * 600 / _GDIPlus_ImageGetWidth($hImage)

	Local $hBitmap = _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight)
	Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsDrawImageRect($hContext, $hImage, 0, 0, $iWidth, $iHeight)

	Local $hGui = GUICreate("GDI+ v1.1 (" & @ScriptName & ")", $iWidth, $iHeight)
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGui)
	GUISetState(@SW_SHOW)

	Local $hEffect = _GDIPlus_EffectCreate($GDIP_HueSaturationLightnessEffectGuid)
	Local $tEffectParameters = DllStructCreate($tagGDIP_EFFECTPARAMS_HueSaturationLightness)

	Local $fW, $fH
	For $i = 1 To 140
		DllStructSetData($tEffectParameters, "HueLevel", Random(-180, 180, 1))
		_GDIPlus_EffectSetParameters($hEffect, $tEffectParameters)
		$fW = Random(20, 100)
		$fH = Random(20, 100)
		_GDIPlus_DrawImageFXEx($hGraphics, $hBitmap, $hEffect, Random(0, $iWidth - $fW), Random(0, $iHeight - $fH), $fW, $fH)
	Next

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	_GDIPlus_GraphicsDispose($hContext)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_EffectDispose($hEffect)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>_Example
