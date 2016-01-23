#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <WinAPIShellEx.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic, $hIcon, $hBitmap

	; Create GUI
	$hGUI = GUICreate("GDI+", 168, 168)
	GUISetState()

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)

	$hIcon = _WinAPI_ShellExtractIcon(@SystemDir & '\shell32.dll', 32, 48, 48)

	$hBitmap = _GDIPlus_BitmapCreateFromHICON($hIcon)

	_GDIPlus_GraphicsDrawImage($hGraphic, $hBitmap, 60, 60)

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_WinAPI_DestroyIcon($hIcon)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
