#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Opt("GUIOnEventMode", 1)

Global $g_idCombo, $g_hGfx_Buffer, $g_hGfx_Buffer_H, $g_hGui, $g_hGraphics, $g_hGraphics_H, $g_hBmp_Buffer_H, $g_hImage, $g_hBmp_Buffer, $g_hGui_Histogram
Global $g_tChannel, $g_iMaxLum

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

	$g_hGui_Histogram = GUICreate("Histogram", 266, 160)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
	$g_idCombo = GUICtrlCreateCombo("", 10, 132, 246, 20)
	GUICtrlSetData(-1, "Alpha|Red|Green|Blue|Grey", "Red")
	GUICtrlSetOnEvent(-1, "_CreateHistogram")
	$g_hGraphics_H = _GDIPlus_GraphicsCreateFromHWND($g_hGui_Histogram)
	$g_hBmp_Buffer_H = _GDIPlus_BitmapCreateFromScan0(259, 122)
	$g_hGfx_Buffer_H = _GDIPlus_ImageGetGraphicsContext($g_hBmp_Buffer_H)
	_GDIPlus_GraphicsSetSmoothingMode($g_hGfx_Buffer_H, 2)

	$g_iMaxLum = _GetHistogramMaxLum()
	_CreateHistogram()

	GUIRegisterMsg($WM_PAINT, "WM_PAINT")
	GUIRegisterMsg($WM_ERASEBKGND, "WM_PAINT")
	GUISetState(@SW_SHOW, $g_hGui)
	GUISetState(@SW_SHOW, $g_hGui_Histogram)

	GUISetOnEvent($GUI_EVENT_MOUSEMOVE, "_ToolTip", $g_hGui_Histogram)

	While Sleep(10)
	WEnd

EndFunc   ;==>_Example

Func _ToolTip()
	Local $aInfo = GUIGetCursorInfo($g_hGui_Histogram)
	If IsArray($aInfo) Then
		If $aInfo[0] < 0 Or $aInfo[0] > 266 Or $aInfo[1] < 0 Or $aInfo[1] > 160 Then Return

		Local $iIndex = $aInfo[0] - 5
		If $iIndex < 1 Then
			$iIndex = 1
		ElseIf $iIndex > 256 Then
			$iIndex = 256
		EndIf

		Local $iValue = DllStructGetData($g_tChannel, 1, $iIndex)

		ToolTip("Index: " & $iIndex & ", Value: " & $iValue)
	EndIf
EndFunc   ;==>_ToolTip

Func _GetHistogramMaxLum()
	Local $iSize = _GDIPlus_BitmapGetHistogramSize($GDIP_HistogramFormatGray)
	Local $tChannel_Grey = DllStructCreate("uint[" & $iSize & "];")
	_GDIPlus_BitmapGetHistogram($g_hImage, $GDIP_HistogramFormatGray, $iSize, $tChannel_Grey)

	Local $iMaxLum = 0
	For $i = 1 To $iSize
		If DllStructGetData($tChannel_Grey, 1, $i) > $iMaxLum Then $iMaxLum = DllStructGetData($tChannel_Grey, 1, $i)
	Next
	Return $iMaxLum
EndFunc   ;==>_GetHistogramMaxLum

Func _CreateHistogram()
	Local $iHistogramFormat, $iColor

	Switch GUICtrlRead($g_idCombo)
		Case "Alpha"
			$iHistogramFormat = $GDIP_HistogramFormatA
			$iColor = 0xFFFF00FF
		Case "Red"
			$iHistogramFormat = $GDIP_HistogramFormatR
			$iColor = 0xFFFF0000
		Case "Green"
			$iHistogramFormat = $GDIP_HistogramFormatG
			$iColor = 0xFF00FF00
		Case "Blue"
			$iHistogramFormat = $GDIP_HistogramFormatB
			$iColor = 0xFF0000FF
		Case "Grey"
			$iHistogramFormat = $GDIP_HistogramFormatGray
			$iColor = 0xFFFFFFFF
		Case Else
			Return
	EndSwitch

	Local $iSize = _GDIPlus_BitmapGetHistogramSize($iHistogramFormat)
	$g_tChannel = DllStructCreate("uint[" & $iSize & "];")

	_GDIPlus_BitmapGetHistogram($g_hImage, $iHistogramFormat, $iSize, $g_tChannel)

	Local $fScale = 1 / $g_iMaxLum * 100
	Local $aPoly[$iSize + 3][2] = [[$iSize + 2]]
	For $i = 1 To $iSize
		$aPoly[$i][0] = $i
		$aPoly[$i][1] = 100 - DllStructGetData($g_tChannel, 1, $i) * $fScale
	Next
	$aPoly[$iSize + 1][0] = $iSize + 1
	$aPoly[$iSize + 1][1] = 100
	$aPoly[$iSize + 2][0] = 1
	$aPoly[$iSize + 2][1] = 100

	_GDIPlus_GraphicsClear($g_hGfx_Buffer_H, 0xFFFFFFFF)
	Local $hBrush = _GDIPlus_LineBrushCreate(1, 0, 258, 0, 0xFF000000, $iColor)
	_GDIPlus_GraphicsFillPolygon($g_hGfx_Buffer_H, $aPoly, $hBrush)
	_GDIPlus_GraphicsFillRect($g_hGfx_Buffer_H, 1, 104, 256, 16, $hBrush)
	_GDIPlus_BrushDispose($hBrush)

	Local $hPen = _GDIPlus_PenCreate(0xFF000000)
	_GDIPlus_GraphicsDrawPolygon($g_hGfx_Buffer_H, $aPoly, $hPen)
	_GDIPlus_GraphicsDrawRect($g_hGfx_Buffer_H, 0, 0, 258, 100, $hPen)
	_GDIPlus_GraphicsDrawRect($g_hGfx_Buffer_H, 0, 103, 258, 18, $hPen)
	_GDIPlus_PenDispose($hPen)

	_GDIPlus_GraphicsDrawImage($g_hGraphics_H, $g_hBmp_Buffer_H, 4, 4)
EndFunc   ;==>_CreateHistogram

Func WM_PAINT($hWnd, $iMsgm, $wParam, $lParam)
	#forceref $iMsgm, $wParam, $lParam
	Switch $hWnd
		Case $g_hGui
			_GDIPlus_GraphicsDrawImage($g_hGraphics, $g_hBmp_Buffer, 0, 0)
		Case $g_hGui_Histogram
			_GDIPlus_GraphicsDrawImage($g_hGraphics_H, $g_hBmp_Buffer_H, 4, 4)
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
