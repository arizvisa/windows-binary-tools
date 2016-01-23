#include <GUIConstantsEx.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $hWnd, $iMsg, $idBtnFlash
	$hWnd = GUICreate("_WinAPI_FlashWindow Example", 200, 200)
	$idBtnFlash = GUICtrlCreateButton("Flash Window", 50, 85, 100, 30)
	GUISetState(@SW_SHOW)
	While 1
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = $GUI_EVENT_CLOSE
				Exit
			Case $iMsg = $idBtnFlash
				GUISetState(@SW_MINIMIZE)
				Sleep(1000)
				_WinAPI_FlashWindow($hWnd)
				Sleep(6000)
		EndSelect
	WEnd
EndFunc   ;==>Example
