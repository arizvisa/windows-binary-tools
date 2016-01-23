#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	; X64 running support
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"

	;get AutoIt install dir
	Local $sRegPath = "HKLM\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt"

	Local $sFile = RegRead($sRegPath, "InstallDir") & "\Examples\GUI\logo4.gif"
	If Not FileExists($sFile) Then
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", $sFile & " not found!", 30)
		Return False
	EndIf

	_GDIPlus_Startup()
	Local $hImage = _GDIPlus_ImageLoadFromFile($sFile) ;create an image object based on a file
	If @error Then
		_GDIPlus_Shutdown()
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "An error has occured - unable to load image!", 30)
		Return False
	EndIf

	Local $iW = _GDIPlus_ImageGetWidth($hImage), $iH = _GDIPlus_ImageGetHeight($hImage) ;get width and height of the image
	Local $hBitmap = _GDIPlus_BitmapCreateFromScan0($iW, $iH)
	Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsDrawImageRect($hContext, $hImage, 0, 0, $iW, $iH)

	Local $tBitmapData = _GDIPlus_BitmapLockBits($hBitmap, 0, 0, $iW, $iH, BitOR($GDIP_ILMWRITE, $GDIP_ILMREAD), $GDIP_PXF32ARGB) ;locks a portion of a bitmap for reading and writing. More infor at http://msdn.microsoft.com/en-us/library/windows/desktop/ms536298(v=vs.85).aspx
	Local $iScan0 = DllStructGetData($tBitmapData, "Scan0") ;get scan0 (pixel data) from locked bitmap
	Local $iSearchPixel = Int(0xFF000080), $iReplaceColor = 0xFF000000 ;color format 0xAARRGGBB
	Local $tPixel = DllStructCreate("int[" & $iW * $iH & "];", $iScan0)
	Local $iPixel, $iRowOffset

	For $iY = 0 To $iH - 1
		$iRowOffset = $iY * $iW + 1
		For $iX = 0 To $iW - 1 ;get each pixel in each line and row
			$iPixel = DllStructGetData($tPixel, 1, $iRowOffset + $iX) ;get pixel color
			If $iPixel = $iSearchPixel Then DllStructSetData($tPixel, 1, $iReplaceColor, $iRowOffset + $iX) ;compare and replace pixel color (blue with black color)
		Next
	Next
	_GDIPlus_BitmapUnlockBits($hBitmap, $tBitmapData) ;unlocks a portion of a bitmap that was locked by _GDIPlus_BitmapLockBits

	;to save manipulated image just use _GDIPlus_ImageSaveToFile()

	ShellExecute($sFile) ;display original image just to compare with manipulated one

	;display manipulated image
	Local $hGUI = GUICreate("_GDIPlus_BitmapLockBits Demo", $iW, $iH)
	GUISetState(@SW_SHOW)

	Local $hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;create a Graphics object from a window handle
	_GDIPlus_GraphicsDrawImageRect($hGraphic, $hBitmap, 0, 0, $iW, $iH) ;copy manipulated image to graphics handle

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	;cleanup resources
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_GraphicsDispose($hContext)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
EndFunc   ;==>Example
