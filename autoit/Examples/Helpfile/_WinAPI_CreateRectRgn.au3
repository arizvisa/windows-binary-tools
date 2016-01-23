#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

; get height of window title and width of window frame - may be different when XP theme is ON/OFF
Global $g_iHtit = _WinAPI_GetSystemMetrics($SM_CYCAPTION)
Global $g_iFrame = _WinAPI_GetSystemMetrics($SM_CXDLGFRAME)

Global $g_hGui = GUICreate("Test Windows regions", 350, 210)
Local $id_Default = GUICtrlCreateButton("Default region", 100, 30, 150)
Local $id_Round = GUICtrlCreateButton("Round region", 100, 60, 150)
Local $id_Buble = GUICtrlCreateButton("Buble region ", 100, 90, 150)
Local $id_Transparent = GUICtrlCreateButton("Transparent region", 100, 120, 150)
Local $id_Exit = GUICtrlCreateButton("Exit", 100, 150, 150)
GUISetState(@SW_SHOW)

Local $aPos = WinGetPos($g_hGui) ; get whole window size (no client size defined in GUICreate)
Global $g_iWidth = $aPos[2]
Global $g_iHeight = $aPos[3]

Local $iMsg, $hRgn
While 1
	$iMsg = GUIGetMsg()
	Select
		Case $iMsg = $GUI_EVENT_CLOSE Or $iMsg = $id_Exit
			ExitLoop

		Case $iMsg = $id_Default
			$hRgn = _WinAPI_CreateRectRgn(0, 0, $g_iWidth, $g_iHeight)
			_WinAPI_SetWindowRgn($g_hGui, $hRgn)

		Case $iMsg = $id_Round
			$hRgn = _WinAPI_CreateRoundRectRgn(0, 0, $g_iWidth, $g_iHeight, $g_iWidth / 3, $g_iHeight / 3)
			_WinAPI_SetWindowRgn($g_hGui, $hRgn)

		Case $iMsg = $id_Buble
			Local $hRgn1 = _WinAPI_CreateRoundRectRgn(0, 0, $g_iWidth / 2, $g_iHeight / 2, $g_iWidth / 2, $g_iHeight / 2) ; left-top
			Local $hRgn2 = _WinAPI_CreateRoundRectRgn($g_iWidth / 2, 0, $g_iWidth, $g_iHeight / 2, $g_iWidth / 2, $g_iHeight / 2) ; right-top
			_WinAPI_CombineRgn($hRgn1, $hRgn1, $hRgn2, $RGN_OR)
			_WinAPI_DeleteObject($hRgn2)
			$hRgn2 = _WinAPI_CreateRoundRectRgn(0, $g_iHeight / 2, $g_iWidth / 2, $g_iHeight, $g_iWidth / 2, $g_iHeight / 2) ; left-bottom
			_WinAPI_CombineRgn($hRgn1, $hRgn1, $hRgn2, $RGN_OR)
			_WinAPI_DeleteObject($hRgn2)
			$hRgn2 = _WinAPI_CreateRoundRectRgn($g_iWidth / 2, $g_iHeight / 2, $g_iWidth, $g_iHeight, $g_iWidth / 2, $g_iHeight / 2) ; right-bottom
			_WinAPI_CombineRgn($hRgn1, $hRgn1, $hRgn2, $RGN_OR)
			_WinAPI_DeleteObject($hRgn2)
			$hRgn2 = _WinAPI_CreateRoundRectRgn(10, 10, $g_iWidth - 10, $g_iHeight - 10, $g_iWidth, $g_iHeight) ; middle
			_WinAPI_CombineRgn($hRgn1, $hRgn1, $hRgn2, $RGN_OR)
			_WinAPI_DeleteObject($hRgn2)
			_WinAPI_SetWindowRgn($g_hGui, $hRgn1)

		Case $iMsg = $id_Transparent
			_GuiHole($g_hGui, 40, 40, 260, 170)

	EndSelect
WEnd

; make inner transparent area but add controls
Func _GuiHole($hWin, $iX, $iY, $iSizeW, $iSizeH)
	Local $hOuter_rgn, $hInner_rgn, $hCombined_rgn

	$hOuter_rgn = _WinAPI_CreateRectRgn(0, 0, $g_iWidth, $g_iHeight)
	$hInner_rgn = _WinAPI_CreateRectRgn($iX, $iY, $iX + $iSizeW, $iY + $iSizeH)
	$hCombined_rgn = _WinAPI_CreateRectRgn(0, 0, 0, 0)
	_WinAPI_CombineRgn($hCombined_rgn, $hOuter_rgn, $hInner_rgn, $RGN_DIFF)
	_WinAPI_DeleteObject($hOuter_rgn)
	_WinAPI_DeleteObject($hInner_rgn)
	_AddCtrlRegion($hCombined_rgn, $id_Default)
	_AddCtrlRegion($hCombined_rgn, $id_Round)
	_AddCtrlRegion($hCombined_rgn, $id_Buble)
	_AddCtrlRegion($hCombined_rgn, $id_Transparent)
	_AddCtrlRegion($hCombined_rgn, $id_Exit)
	_WinAPI_SetWindowRgn($hWin, $hCombined_rgn)
EndFunc   ;==>_GuiHole

; add control's area to given region
; respecting also window title/frame sizes
Func _AddCtrlRegion($hFull_rgn, $idCtrl)
	Local $aCtrl_pos, $hCtrl_rgn

	$aCtrl_pos = ControlGetPos($g_hGui, "", $idCtrl)
	$hCtrl_rgn = _WinAPI_CreateRectRgn($aCtrl_pos[0] + $g_iFrame, $aCtrl_pos[1] + $g_iHtit + $g_iFrame, _
			$aCtrl_pos[0] + $aCtrl_pos[2] + $g_iFrame, $aCtrl_pos[1] + $aCtrl_pos[3] + $g_iHtit + $g_iFrame)
	_WinAPI_CombineRgn($hFull_rgn, $hFull_rgn, $hCtrl_rgn, $RGN_OR)
	_WinAPI_DeleteObject($hCtrl_rgn)
EndFunc   ;==>_AddCtrlRegion
