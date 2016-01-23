#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hBitmap, $hImage, $aRet

	; Create GUI
	GUICreate("GDI+", 600, 400)
	$g_idMemo = GUICtrlCreateEdit("", 2, 2, 596, 396, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Initialize GDI+ library
	_GDIPlus_Startup()

	; Capture 32 bit bitmap
	$hBitmap = _ScreenCapture_Capture("")
	$hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)

	; Show enumeration of pixel data attributes for screen capture
	$aRet = _GDIPlus_ImageGetFlags($hImage)
	$aRet[1] = @CRLF & StringReplace($aRet[1], "|", @CRLF)
	MemoWrite("Image pixel data attributes of screen capture: " & $aRet[1]);
	MemoWrite();
	MemoWrite("Image flag set of pixel data attributes: " & $aRet[0]);
	MemoWrite();

	; Save screen capture bitmap to file
	_GDIPlus_ImageSaveToFile($hImage, @MyDocumentsDir & "\GDIPlus_Image.jpg")

	; Clean up resources
	_GDIPlus_ImageDispose($hImage)
	_WinAPI_DeleteObject($hBitmap)

	; Load screen capture bitmap from file
	$hImage = _GDIPlus_ImageLoadFromFile(@MyDocumentsDir & "\GDIPlus_Image.jpg")

	; Show enumeration of pixel data attributes for saved file
	$aRet = _GDIPlus_ImageGetFlags($hImage)
	$aRet[1] = @CRLF & StringReplace($aRet[1], "|", @CRLF)
	MemoWrite("Image pixel data attributes of saved file: " & $aRet[1]);
	MemoWrite();
	MemoWrite("Image flag set of pixel data attributes: " & $aRet[0]);

	; Clean up resources
	_GDIPlus_ImageDispose($hImage)

	; Shut down GDI+ library
	_GDIPlus_Shutdown()

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage = '')
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
