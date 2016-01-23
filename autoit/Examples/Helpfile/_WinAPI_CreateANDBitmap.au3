#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPIShPath.au3>

Local Const $sPng = @ScriptDir & '\Extras\Silverlight.png'

Local $a_hBitmap[2]
; Create 32 bits-per-pixel bitmap from a PNG image
Global $g_hDll = _GDIPlus_Startup(Default, True)
Local $hPng = _GDIPlus_ImageLoadFromFile($sPng)
$a_hBitmap[0] = _GDIPlus_BitmapCreateDIBFromBitmap($hPng)
Local $iWidth = _GDIPlus_ImageGetWidth($hPng)
Local $iHeight = _GDIPlus_ImageGetHeight($hPng)
_GDIPlus_ImageDispose($hPng)
_GDIPlus_Shutdown()

; Create 1 bits-per-pixel AND bitmask bitmap
$a_hBitmap[1] = _WinAPI_CreateANDBitmap($a_hBitmap[0])

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), $iWidth * 2, $iHeight)
Local $aidPic[2]
$aidPic[0] = GUICtrlCreatePic('', 0, 0, $iWidth, $iHeight)
$aidPic[1] = GUICtrlCreatePic('', $iWidth, 0, $iWidth, $iHeight)

; Set both bitmaps to controls
For $i = 0 To 1
	GUICtrlSendMsg($aidPic[$i], $STM_SETIMAGE, 0, $a_hBitmap[$i])
Next

; Show GUI
GUISetState(@SW_SHOW)

; Create and save icon to .ico file
Local $hIcon
Local $sPath = FileSaveDialog('Save Icon', @ScriptDir, 'Icon Files (*.ico)', 2 + 16, _WinAPI_PathStripPath(_WinAPI_PathRenameExtension($sPng, '.ico')), $hForm)
If $sPath Then
	$hIcon = _WinAPI_CreateIconIndirect($a_hBitmap[0], $a_hBitmap[1])
	If $hIcon Then
		_WinAPI_SaveHICONToFile($sPath, $hIcon)
		_WinAPI_DestroyIcon($hIcon)
	EndIf
EndIf

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

; Unlike _GDIPlus_BitmapCreateHBITMAPFromBitmap() that creates a device-dependent bitmap (DDB), this function creates a device-independent bitmap (DIB) which may be used for semi-transparent images

Func _GDIPlus_BitmapCreateDIBFromBitmap($hBitmap)
	Local $aSize = DllCall($g_hDll, 'uint', 'GdipGetImageDimension', 'ptr', $hBitmap, 'float*', 0, 'float*', 0)
	If @error Or $aSize[0] Then Return 0

	Local $tData = _GDIPlus_BitmapLockBits($hBitmap, 0, 0, $aSize[2], $aSize[3], $GDIP_ILMREAD, $GDIP_PXF32ARGB)
	Local $pBits = DllStructGetData($tData, 'Scan0')
	If Not $pBits Then Return 0

	Local $hDIB = _WinAPI_CreateDIB($aSize[2], $aSize[3])
	If Not @error Then
		_WinAPI_SetBitmapBits($hDIB, $aSize[2] * $aSize[3] * 4, $pBits)
	EndIf
	_GDIPlus_BitmapUnlockBits($a_hBitmap, $tData)
	Return $hDIB
EndFunc   ;==>_GDIPlus_BitmapCreateDIBFromBitmap
