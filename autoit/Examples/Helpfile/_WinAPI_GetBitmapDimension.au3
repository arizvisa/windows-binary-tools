#include <WinAPIGdi.au3>

Local $hBitmap = _WinAPI_LoadImage(0, @ScriptDir & '\Extras\AutoIt.bmp', $IMAGE_BITMAP, 0, 0, $LR_LOADFROMFILE)
Local $tSIZE = _WinAPI_GetBitmapDimension($hBitmap)
_WinAPI_DeleteObject($hBitmap)

ConsoleWrite(DllStructGetData($tSIZE, 'X') & ' x ' & DllStructGetData($tSIZE, 'Y') & @CRLF)
