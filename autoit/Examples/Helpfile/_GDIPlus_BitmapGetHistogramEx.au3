#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Opt("GUIOnEventMode", 1)

Global $g_idCombo, $g_hGfx_Buffer, $g_hGfx_Buffer_H, $g_hGui, $g_hGraphics, $g_hGraphics_H, $g_hBmp_Buffer_H, $g_hImage, $g_hBmp_Buffer, $g_hGui_Histogram

_Example()

Func _Example()
	If Not _GDIPlus_Startup() Or @extended < 6 Then
		MsgBox($MB_SYSTEMMODAL, "ERROR", "GDIPlus.dll v1.1 not available")
		Return
	EndIf

	Local $sFile = FileOpenDialog("Select an image", "", "Images (*.bmp;*.png;*.jpg;*.gif;*.tif)")
	If @error Or Not FileExists($sFile) Then Return

	$g_hImage = _GDIPlus_ImageLoadFromFile($sFile)

	Local $iWidth = 600
	Local $iHeight = _GDIPlus_ImageGetHeight($g_hImage) * 600 / _GDIPlus_ImageGetWidth($g_hImage)

	$g_hGui = GUICreate("GDI+ v1.1 (" & @ScriptName & ")", $iWidth, $iHeight)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
	$g_hGraphics = _GDIPlus_GraphicsCreateFromHWND($g_hGui)
	$g_hBmp_Buffer = _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight)
	$g_hGfx_Buffer = _GDIPlus_ImageGetGraphicsContext($g_hBmp_Buffer)
	_GDIPlus_GraphicsDrawImageRect($g_hGfx_Buffer, $g_hImage, 0, 0, $iWidth, $iHeight)

	$g_hGui_Histogram = GUICreate("Histogram", 1029, 140)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
	$g_hGraphics_H = _GDIPlus_GraphicsCreateFromHWND($g_hGui_Histogram)
	$g_hBmp_Buffer_H = _GDIPlus_BitmapCreateFromScan0(1029, 140)
	$g_hGfx_Buffer_H = _GDIPlus_ImageGetGraphicsContext($g_hBmp_Buffer_H)
	_GDIPlus_GraphicsSetSmoothingMode($g_hGfx_Buffer_H, 2)

	Local $tHistogram = _GDIPlus_BitmapGetHistogramEx($g_hImage)
	_DrawHistogram($tHistogram)

	GUIRegisterMsg($WM_PAINT, "WM_PAINT")
	GUIRegisterMsg($WM_ERASEBKGND, "WM_PAINT")
	GUISetState(@SW_SHOW, $g_hGui)
	GUISetState(@SW_SHOW, $g_hGui_Histogram)

	While Sleep(10)
	WEnd
EndFunc   ;==>_Example

Func _DrawHistogram($tHistogram)
	_GDIPlus_GraphicsClear($g_hGfx_Buffer_H, 0xFFFFFFFF)

	Local $iValue
	Local $fScale = 1 / $tHistogram.MaxGrey * 100

	Local $aPoly[259][2] = [[258]]
	$aPoly[257][0] = 256
	$aPoly[257][1] = 100
	$aPoly[258][0] = 1
	$aPoly[258][1] = 100

	Local $hBrush = _GDIPlus_LineBrushCreate(1, 0, 256, 0, 0xFF000000, 0xFFFF0000, 3)
	Local $hPen = _GDIPlus_PenCreate(0xBB000000, 1)

	For $i = 1 To 256
		$iValue = DllStructGetData($tHistogram, "Red", $i) * $fScale
		If $iValue > 100 Then $iValue = 100
		$aPoly[$i][0] = $i
		$aPoly[$i][1] = 100 - $iValue
	Next
	_GDIPlus_GraphicsResetTransform($g_hGfx_Buffer_H)
	_GDIPlus_GraphicsTranslateTransform($g_hGfx_Buffer_H, 0, 20)
	_GDIPlus_GraphicsFillPolygon($g_hGfx_Buffer_H, $aPoly, $hBrush)
	_GDIPlus_GraphicsDrawPolygon($g_hGfx_Buffer_H, $aPoly, $hPen)
	_GDIPlus_GraphicsFillRect($g_hGfx_Buffer_H, 1, 102, 255, 16, $hBrush)
	_GDIPlus_GraphicsDrawRect($g_hGfx_Buffer_H, 1, 102, 255, 16, $hPen)
	_GDIPlus_GraphicsDrawString($g_hGfx_Buffer_H, "Red", 30, -15)

	For $i = 1 To 256
		$iValue = DllStructGetData($tHistogram, "Green", $i) * $fScale
		If $iValue > 100 Then $iValue = 100
		$aPoly[$i][1] = 100 - $iValue
	Next
	_GDIPlus_LineBrushSetColors($hBrush, 0xFF000000, 0xFF00FF00)
	_GDIPlus_GraphicsTranslateTransform($g_hGfx_Buffer_H, 257, 0)
	_GDIPlus_GraphicsFillPolygon($g_hGfx_Buffer_H, $aPoly, $hBrush)
	_GDIPlus_GraphicsDrawPolygon($g_hGfx_Buffer_H, $aPoly, $hPen)
	_GDIPlus_GraphicsFillRect($g_hGfx_Buffer_H, 1, 102, 255, 16, $hBrush)
	_GDIPlus_GraphicsDrawRect($g_hGfx_Buffer_H, 1, 102, 255, 16, $hPen)
	_GDIPlus_GraphicsDrawString($g_hGfx_Buffer_H, "Green", 30, -15)

	For $i = 1 To 256
		$iValue = DllStructGetData($tHistogram, "Blue", $i) * $fScale
		If $iValue > 100 Then $iValue = 100
		$aPoly[$i][1] = 100 - $iValue
	Next
	_GDIPlus_LineBrushSetColors($hBrush, 0xFF000000, 0xFF0000FF)
	_GDIPlus_GraphicsTranslateTransform($g_hGfx_Buffer_H, 257, 0)
	_GDIPlus_GraphicsFillPolygon($g_hGfx_Buffer_H, $aPoly, $hBrush)
	_GDIPlus_GraphicsDrawPolygon($g_hGfx_Buffer_H, $aPoly, $hPen)
	_GDIPlus_GraphicsFillRect($g_hGfx_Buffer_H, 1, 102, 255, 16, $hBrush)
	_GDIPlus_GraphicsDrawRect($g_hGfx_Buffer_H, 1, 102, 255, 16, $hPen)
	_GDIPlus_GraphicsDrawString($g_hGfx_Buffer_H, "Blue", 30, -15)

	For $i = 1 To 256
		$iValue = DllStructGetData($tHistogram, "Grey", $i) * $fScale
		If $iValue > 100 Then $iValue = 100
		$aPoly[$i][1] = 100 - $iValue
	Next
	_GDIPlus_LineBrushSetColors($hBrush, 0xFF000000, 0xFFFFFFFF)
	_GDIPlus_GraphicsTranslateTransform($g_hGfx_Buffer_H, 257, 0)
	_GDIPlus_GraphicsFillPolygon($g_hGfx_Buffer_H, $aPoly, $hBrush)
	_GDIPlus_GraphicsDrawPolygon($g_hGfx_Buffer_H, $aPoly, $hPen)
	_GDIPlus_GraphicsFillRect($g_hGfx_Buffer_H, 1, 102, 255, 16, $hBrush)
	_GDIPlus_GraphicsDrawRect($g_hGfx_Buffer_H, 1, 102, 255, 16, $hPen)
	_GDIPlus_GraphicsDrawString($g_hGfx_Buffer_H, "Grey", 30, -15)

	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_PenDispose($hPen)
EndFunc   ;==>_DrawHistogram

Func WM_PAINT($hWnd, $iMsgm, $wParam, $lParam)
	#forceref $iMsgm, $wParam, $lParam
	Switch $hWnd
		Case $g_hGui
			_GDIPlus_GraphicsDrawImage($g_hGraphics, $g_hBmp_Buffer, 0, 0)
		Case $g_hGui_Histogram
			_GDIPlus_GraphicsDrawImage($g_hGraphics_H, $g_hBmp_Buffer_H, 0, 0)
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_PAINT

Func _Exit()
	_GDIPlus_ImageDispose($g_hImage)
	_GDIPlus_GraphicsDispose($g_hGfx_Buffer_H)
	_GDIPlus_BitmapDispose($g_hBmp_Buffer_H)
	_GDIPlus_GraphicsDispose($g_hGraphics_H)
	_GDIPlus_GraphicsDispose($g_hGfx_Buffer)
	_GDIPlus_BitmapDispose($g_hBmp_Buffer)
	_GDIPlus_GraphicsDispose($g_hGraphics)
	_GDIPlus_Shutdown()
	Exit
EndFunc   ;==>_Exit
