#include <GDIPlus.au3>
#include <MsgBoxConstants.au3>

Global $g_hBitmap

Example()

Func Example()
	Local $sFile = FileOpenDialog("Select an image (non JPG)", "", "Images (*.bmp;*.png;*.gif;*.tif)")
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "Aborted", 30)
		Return False
	EndIf

	_GDIPlus_Startup() ;initialize GDI+

	$g_hBitmap = _GDIPlus_BitmapCreateFromFile($sFile) ;create a bitmap object from file
	If @error Then
		_GDIPlus_Shutdown()
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "An error has occured - unable to load image!", 30)
		Return False
	EndIf

	Local $sNewJPGFile = StringTrimRight($sFile, 3) & "jpg", $iAnswer = 0

	If FileExists($sNewJPGFile) Then
		$iAnswer = MsgBox(BitOR($MB_SYSTEMMODAL, $MB_YESNO, $MB_ICONQUESTION), "", '"' & $sNewJPGFile & '" already exists. Overwrite?')
		If $iAnswer <> $IDYES Then
			_ReleaseResources()
			Return False
		EndIf
	EndIf

	_GDIPlus_ImageSaveToFile($g_hBitmap, $sNewJPGFile) ;save image in JPG format
	If @error Then
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", "An error has occured - unable to save image!", 30)
	Else
		ShellExecute($sNewJPGFile)
	EndIf

	_ReleaseResources()
EndFunc   ;==>Example

Func _ReleaseResources()
	_GDIPlus_BitmapDispose($g_hBitmap) ;release a bitmap object
	_GDIPlus_Shutdown()
EndFunc   ;==>_ReleaseResources
