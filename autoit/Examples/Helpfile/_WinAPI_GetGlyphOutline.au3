#include <APIGdiConstants.au3>
#include <FontConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPISys.au3>
#include <WindowsConstants.au3>

; Creates logical font ("Times") and retrieve bitmap bits for a random character
Local $hDC = _WinAPI_CreateCompatibleDC(0)
Local $hFont = _WinAPI_CreateFont(512, 0, 0, 0, 400, False, False, False, $DEFAULT_CHARSET, $OUT_DEFAULT_PRECIS, $CLIP_DEFAULT_PRECIS, $DEFAULT_QUALITY, 0, 'Times')
Local $hSv = _WinAPI_SelectObject($hDC, $hFont)
Local $pData = 0
Local $tGM = _WinAPI_GetGlyphOutline($hDC, ChrW(Random(65, 90, 1)), $GGO_BITMAP, $pData)
Local $W = DllStructGetData($tGM, 'BlackBoxX')
Local $H = DllStructGetData($tGM, 'BlackBoxY')
_WinAPI_SelectObject($hDC, $hSv)
_WinAPI_DeleteObject($hFont)

; Create 1 bits-per-pixel bitmap
Local $hBmp = _WinAPI_CreateBitmap(32 * Ceiling($W / 32), $H, 1, 1, $pData)

; Crop bitmap to the required size and colorize it
Local $aColorTable[2] = [0xFFFFFF, 0xC00000]
Local $hDib = _WinAPI_CreateDIB($W, $H, 1, _WinAPI_CreateDIBColorTable($aColorTable), 2)
$hSv = _WinAPI_SelectObject($hDC, $hDib)
_WinAPI_DrawBitmap($hDC, 0, 0, $hBmp, $MERGEPAINT)
_WinAPI_SelectObject($hDC, $hSv)
_WinAPI_DeleteObject($hBmp)

; Free unnecessary resources
_WinAPI_FreeMemory($pData)
_WinAPI_DeleteDC($hDC)

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), $W, $H)
Local $idPic = GUICtrlCreatePic('', 0, 0, $W, $H)
Local $hPic = GUICtrlGetHandle($idPic)

; Set bitmap to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hDib)
$hBmp = _SendMessage($hPic, $STM_GETIMAGE)
If $hBmp <> $hDib Then
	_WinAPI_DeleteObject($hDib)
EndIf

; Show GUI
GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
