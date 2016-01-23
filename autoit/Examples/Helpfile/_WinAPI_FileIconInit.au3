#include <GUIConstantsEx.au3>
#include <GUIImageList.au3>
#include <StaticConstants.au3>
#include <WinAPIRes.au3>
#include <WinAPIShPath.au3>

; Initialize system image list
_WinAPI_FileIconInit()

; Retrieve system image list and calculate bitmap size
Local $hImageList = _WinAPI_ShellGetImageList()
If @error Then Exit

Local $iCount = _GUIImageList_GetImageCount($hImageList)
Local $a_iSize = _GUIImageList_GetIconSize($hImageList)
Local $iCX = Sqrt($iCount)
Local $iCY
If $iCX Then
	$iCX = Ceiling($iCX)
	$iCY = Ceiling($iCount / $iCX)
Else
	$iCX = 1
	$iCY = 1
EndIf
Local $W = $iCX * ($a_iSize[0] + 14)
Local $H = $iCY * ($a_iSize[1] + 14)

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), $W, $H)
Local $idPic = GUICtrlCreatePic('', 0, 0, $W, $H)
Local $hPic = GUICtrlGetHandle($idPic)

; Create bitmap
Local $hDC = _WinAPI_GetDC($hPic)
Local $hMemDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmap($hDC, $W, $H)
Local $hMemSv = _WinAPI_SelectObject($hMemDC, $hBitmap)

; Draw all icons from the system image list into bitmap
Local $iIndex = 0
For $y = 1 To $iCY
	For $x = 1 To $iCX
		_GUIImageList_Draw($hImageList, $iIndex, $hMemDC, ($x - 1) * ($a_iSize[0] + 14) + 7, ($y - 1) * ($a_iSize[0] + 14) + 7)
		$iIndex += 1
		If $iIndex >= $iCount Then
			ExitLoop
		EndIf
	Next
Next

; Release objects
_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_SelectObject($hMemDC, $hMemSv)
_WinAPI_DeleteDC($hMemDC)

; Set bitmap to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
Local $hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

; Show GUI
GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
