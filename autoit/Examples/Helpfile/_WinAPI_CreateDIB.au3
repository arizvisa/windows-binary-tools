#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPIMisc.au3>
#include <WinAPISys.au3>

; Create array of colors of 256 entries required for 8 bits-per-pixel bitmap
Local $aColorTable[256]
For $i = 0 To 255
	$aColorTable[$i] = _WinAPI_RGB(0, $i, 255 - $i)
Next

; Create color table from an array of colors
Local $tColorTable = _WinAPI_CreateDIBColorTable($aColorTable)

; Create 8 bits-per-pixel device-independent bitmap (DIB) and retrieve a pointer to the location of its bit values
Local $hBitmap = _WinAPI_CreateDIB(256, 256, 8, $tColorTable, 256)
Local $pBits = _WinAPI_GetExtended()

; Fill bitmap color indexes
For $i = 0 To 255
	_WinAPI_FillMemory($pBits + 256 * $i, 256, $i)
Next

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 256, 256)
Local $idPic = GUICtrlCreatePic('', 0, 0, 256, 256)
Local $hPic = GUICtrlGetHandle($idPic)

; Create DDB from DIB to correct display in control
Local $hDC = _WinAPI_GetDC($hPic)
Local $hDev = _WinAPI_CreateCompatibleBitmap($hDC, 256, 256)
Local $hMemDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hMemSv = _WinAPI_SelectObject($hMemDC, $hDev)
_WinAPI_DrawBitmap($hMemDC, 0, 0, $hBitmap)
_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_SelectObject($hMemDC, $hMemSv)
_WinAPI_DeleteDC($hMemDC)

; Set bitmap to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hDev)
Local $hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hDev Then
	_WinAPI_DeleteObject($hDev)
EndIf

; Show GUI
GUISetState(@SW_SHOW)

; Save 8 bits-per-pixel bitmap to .bmp file
Local $sPath = FileSaveDialog('Save Image', @TempDir, 'Bitmap Image Files (*.bmp)', 2 + 16, 'MyImage.bmp', $hForm)
If $sPath Then
	_WinAPI_SaveHBITMAPToFile($sPath, $hBitmap, 2834, 2834)
EndIf

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
