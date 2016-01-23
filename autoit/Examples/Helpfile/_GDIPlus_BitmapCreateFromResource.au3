#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()

	_GDIPlus_Startup() ;initialize GDI+
	Local Const $iWidth = 300, $iHeight = 300, $iBgColor = 0x404040 ;$iBgColor format RRGGBB

	Local $hGUI = GUICreate("GDI+ Example (" & @ScriptName & ")", $iWidth, $iHeight) ;create a test GUI
	GUISetBkColor($iBgColor, $hGUI) ;set GUI background color
	GUISetState(@SW_SHOW)

	Local $sAut2Exe = StringRegExpReplace(@AutoItExe, "\\\w+.exe", "\\Aut2Exe\\Aut2Exe.exe") ;get path to the Aut2Exe.exe file
	If @AutoItX64 Then $sAut2Exe = StringRegExpReplace(@AutoItExe, "\\\w+.exe", "\\Aut2Exe\\Aut2Exe_X64.exe")

	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;create a graphics object from a window handle
	Local $hInst = _WinAPI_LoadLibrary($sAut2Exe) ;maps a specified executable module into the address space of the calling process
	Local $hBitmap = _GDIPlus_BitmapCreateFromResource($hInst, "BMP_MAINLOGO") ;load bitmap resource "BMP_MAINLOGO" and convert it to GDI+ bitmap format
	Local $iW = _GDIPlus_ImageGetWidth($hBitmap), $iH = _GDIPlus_ImageGetHeight($hBitmap)
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, ($iWidth - $iW) / 2, ($iHeight - $iH) / 2) ;display image in GUI centered

	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	;cleanup GDI+ resources
	_WinAPI_FreeLibrary($hInst)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
	Exit
EndFunc   ;==>Example
