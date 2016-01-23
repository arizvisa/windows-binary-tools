#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>

Example()

Func Example()
	_GDIPlus_Startup()
	Local Const $iW = @DesktopWidth / 2, $iH = @DesktopHeight / 2
	Local $hGUI = GUICreate("GDI+ test", $iW, $iH, -1, -1)
	GUISetState(@SW_SHOW)

	Local $hHBmp = _ScreenCapture_Capture("", 0, 0, @DesktopWidth / 2, @DesktopHeight / 2) ;create a GDI bitmap by capturing 1/4 of desktop
	Local $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hHBmp) ;convert GDI bitmap to GDI+ bitmap
	_WinAPI_DeleteObject($hHBmp) ;release GDI bitmap resource because not needed anymore

	Local $sImgCLSID = _GDIPlus_EncodersGetCLSID("jpg") ;create CLSID for a JPG image file type
	Local $tGUID = _WinAPI_GUIDFromString($sImgCLSID) ;convert CLSID GUID to binary form and returns $tagGUID structure
	Local $tParams = _GDIPlus_ParamInit(1) ;initialize an encoder parameter list and return $tagGDIPENCODERPARAMS structure
	Local $tData = DllStructCreate("int Quality") ;create struct to set JPG quality setting
	DllStructSetData($tData, "Quality", 10) ;quality 0-100 (0: lowest, 100: highest)
	Local $pData = DllStructGetPtr($tData) ;get pointer from quality struct
	_GDIPlus_ParamAdd($tParams, $GDIP_EPGQUALITY, 1, $GDIP_EPTLONG, $pData) ;add a value to an encoder parameter list
	Local $pStream = _WinAPI_CreateStreamOnHGlobal() ;create stream
	_GDIPlus_ImageSaveToStream($hBitmap, $pStream, $tGUID, $tParams) ;save the bitmap in JPG format in memory
	Local $hBitmapFromStream = _GDIPlus_BitmapCreateFromStream($pStream) ;create bitmap from a stream (here from the JPG in memory)

	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;create a graphics object from a window handle
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmapFromStream, 0, 0) ;display streamed image

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	;cleanup resources
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_BitmapDispose($hBitmapFromStream)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
EndFunc   ;==>Example
