#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPIShellEx.au3>
#include <WindowsConstants.au3>

Opt('MouseCoordMode', 2)

Global $g_iCount = 0

OnAutoItExitRegister('OnAutoItExit')

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 400, 400)
Local $idPic = GUICtrlCreatePic('', 0, 0, 400, 400)
GUICtrlSetCursor(-1, 0)
Local $hPic = GUICtrlGetHandle($idPic)
Local $idLabel = GUICtrlCreateLabel('', 176, 176, 48, 48)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
Global $g_hLabel = GUICtrlGetHandle($idLabel)

; Extract icon
Local $hIcon = _WinAPI_ShellExtractIcon(@SystemDir & '\shell32.dll', 130, 48, 48)

; Register label window proc
Global $g_hDll = DllCallbackRegister('_WinProc', 'ptr', 'hwnd;uint;wparam;lparam')
Local $pDll = DllCallbackGetPtr($g_hDll)
Global $g_hProc = _WinAPI_SetWindowLong($g_hLabel, $GWL_WNDPROC, $pDll)

; Create gradient
Local $hDC = _WinAPI_GetDC($hPic)
Local $hDestDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmap($hDC, 400, 400)
Local $hDestSv = _WinAPI_SelectObject($hDestDC, $hBitmap)
Local $aVertex[2][3] = [[0, 0, 0xAA00FF], [400, 400, 0x33004D]]
_WinAPI_GradientFill($hDestDC, $aVertex)

_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_SelectObject($hDestDC, $hDestSv)
_WinAPI_DeleteDC($hDestDC)

; Set gradient to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
Local $hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

GUISetState(@SW_SHOW)

Local $aPos
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $GUI_EVENT_PRIMARYDOWN
			$aPos = MouseGetPos()
			If _WinAPI_PtInRectEx($aPos[0], $aPos[1], 0, 0, 400, 400) Then
				GUICtrlSetPos($idLabel, $aPos[0] - 24, $aPos[1] - 24)
			EndIf
	EndSwitch
WEnd

Func _WinProc($hWnd, $iMsg, $wParam, $lParam)
	Switch $iMsg
		Case $WM_PAINT
			If $g_iCount = 0 Then
				Local $tPAINTSTRUCT, $hDC

				$g_iCount += 1
				$hDC = _WinAPI_BeginPaint($hWnd, $tPAINTSTRUCT)
				_WinAPI_DrawIconEx($hDC, 0, 0, $hIcon, 48, 48)
				_WinAPI_EndPaint($hWnd, $tPAINTSTRUCT)
				$g_iCount -= 1
				Return 0
			EndIf
	EndSwitch
	Return _WinAPI_CallWindowProc($g_hProc, $hWnd, $iMsg, $wParam, $lParam)
EndFunc   ;==>_WinProc

Func OnAutoItExit()
	_WinAPI_SetWindowLong($g_hLabel, $GWL_WNDPROC, $g_hProc)
	DllCallbackFree($g_hDll)
EndFunc   ;==>OnAutoItExit
