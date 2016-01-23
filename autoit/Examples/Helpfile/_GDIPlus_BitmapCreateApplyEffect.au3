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

	Local $hEffect = _GDIPlus_EffectCreateBlur()

	Local $tRECT = DllStructCreate($tagRECT)
	Local $hBitmap = _GDIPlus_BitmapCreateApplyEffect($hImage, $hEffect, Null, $tRECT)

	Local $iBmpW = $tRECT.Right - $tRECT.Left
	Local $iBmpH = $tRECT.Bottom - $tRECT.Top

	Local $iWidth = 600
	Local $iHeight = $iBmpH * 600 / $iBmpW

	Local $hGui = GUICreate("GDI+ v1.1 (" & @ScriptName & ")", $iWidth, $iHeight)
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGui)
	GUISetState(@SW_SHOW)

	_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $iWidth, $iHeight)

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	_GDIPlus_EffectDispose($hEffect)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>_Example
