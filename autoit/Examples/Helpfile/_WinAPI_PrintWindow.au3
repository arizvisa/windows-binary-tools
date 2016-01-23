#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>

Run(@SystemDir & '\calc.exe')
Local $hWnd = WinWaitActive("[CLASS:CalcFrame]", '', 3)
If Not $hWnd Then
	Exit
EndIf

; Create GUI
Local $iSize = WinGetPos($hWnd)
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), $iSize[2] + 80, $iSize[3] + 80)
Local $idPic = GUICtrlCreatePic('', 40, 40, $iSize[2], $iSize[3])
Local $hPic = GUICtrlGetHandle($idPic)

; Create bitmap
Local $hDC = _WinAPI_GetDC($hPic)
Local $hDestDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmap($hDC, $iSize[2], $iSize[3])
Local $hDestSv = _WinAPI_SelectObject($hDestDC, $hBitmap)
Local $hSrcDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBmp = _WinAPI_CreateCompatibleBitmap($hDC, $iSize[2], $iSize[3])
Local $hSrcSv = _WinAPI_SelectObject($hSrcDC, $hBmp)
_WinAPI_PrintWindow($hWnd, $hSrcDC)
_WinAPI_BitBlt($hDestDC, 0, 0, $iSize[2], $iSize[3], $hSrcDC, 0, 0, $MERGECOPY)

_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_SelectObject($hDestDC, $hDestSv)
_WinAPI_SelectObject($hSrcDC, $hSrcSv)
_WinAPI_DeleteDC($hDestDC)
_WinAPI_DeleteDC($hSrcDC)
_WinAPI_DeleteObject($hBmp)

; Set bitmap to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
Local $hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

WinClose("[CLASS:CalcFrame]", "")
