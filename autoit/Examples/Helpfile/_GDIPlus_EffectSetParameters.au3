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

	Local $hGui = GUICreate("GDI+ v1.1 (" & @ScriptName & ")", $iWidth, $iHeight)
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGui)
	GUISetState(@SW_SHOW)

	Local $hEffect = _GDIPlus_EffectCreate($GDIP_BlurEffectGuid)
	Local $tEffectParameters = DllStructCreate($tagGDIP_EFFECTPARAMS_Blur)

	Local $hBitmap
	For $i = 0 To 12
		DllStructSetData($tEffectParameters, "Radius", Abs($i - 6) * 4)
		_GDIPlus_EffectSetParameters($hEffect, $tEffectParameters)

		$hBitmap = _GDIPlus_BitmapCreateApplyEffectEx($hImage, $hEffect, $i * Ceiling($iImgW / 13), 0, Ceiling($iImgW / 13) * 2, $iImgH)

		_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, $i * Ceiling($iWidth / 13), 0, Ceiling($iWidth / 13), $iHeight)
		_GDIPlus_BitmapDispose($hBitmap)
	Next

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	_GDIPlus_EffectDispose($hEffect)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>_Example
