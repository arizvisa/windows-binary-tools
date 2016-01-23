#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <ScreenCapture.au3>

Example()

Func Example()
	_GDIPlus_Startup()
	Local Const $iW = @DesktopWidth / 4, $iH = @DesktopHeight / 4
	Local $hGUI = GUICreate("GDI+ test", $iW, $iH, -1, 10)
	GUISetState(@SW_SHOW)

	Local $aIM[8] = ["Default", "Low Quality", "High Quality", "Bilinear", "Bicubic", "Nearest Neighbor", "High Quality Bilinear", "High Quality Bicubic"]

	Local $hHBmp = _ScreenCapture_Capture("", 0, 0, -1, -1) ;create a GDI bitmap by capturing whole desktop
	Local $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hHBmp) ;convert GDI to GDI+ bitmap
	_WinAPI_DeleteObject($hHBmp) ;release GDI bitmap resource because not needed anymore

	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;create a graphics object from a window handle
	Local $iIM = _GDIPlus_GraphicsGetInterpolationMode($hGraphics)
	_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $iW, $iH) ;draw captured bitmap to GUI with default system interpolation mode
	MsgBox($MB_SYSTEMMODAL, "", "Interpolation Mode initial: " & $aIM[$iIM])

	_GDIPlus_GraphicsSetInterpolationMode($hGraphics, $GDIP_INTERPOLATIONMODE_NearestNeighbor) ;change interpolation mode
	_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $iW, $iH) ;draw again same bitmap but with different interpolation mode
	$iIM = _GDIPlus_GraphicsGetInterpolationMode($hGraphics)
	MsgBox($MB_SYSTEMMODAL, "", "Interpolation Mode after: " & $aIM[$iIM])

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	;cleanup resources
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
EndFunc   ;==>Example
