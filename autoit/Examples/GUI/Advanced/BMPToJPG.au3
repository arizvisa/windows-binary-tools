#include <GDIPlus.au3>

; ===============================================================================================================================
; Description ...: Shows how to convert a BMP file to JPG
; Author ........: Paul Campbell (PaulIA)
; Notes .........:
; ===============================================================================================================================

; Get BMP file to convert
Local $sImage = InputBox("BMP to JPG", "Enter File Name:", @MyDocumentsDir & "\Image.bmp", "", 200, 130)
If @error Or Not FileExists($sImage) Then Exit -1

; Initialize GDI+ library
_GDIPlus_Startup()

; Load image
Local $hImage = _GDIPlus_ImageLoadFromFile($sImage)

; Get JPG encoder CLSID
Local $sCLSID = _GDIPlus_EncodersGetCLSID("JPG")

; Save image as JPG
_GDIPlus_ImageSaveToFileEx($hImage, @MyDocumentsDir & "\AutoItImage.jpg", $sCLSID)

; Shut down GDI+ library
_GDIPlus_Shutdown()
