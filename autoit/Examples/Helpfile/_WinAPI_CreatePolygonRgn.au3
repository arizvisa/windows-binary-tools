#include <GUIConstantsEx.au3>
#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 500, 475, -1, -1, $WS_POPUP, $WS_EX_TOPMOST)
Local $idButton = GUICtrlCreateButton('Exit', 215, 255, 70, 23)
GUIRegisterMsg($WM_NCHITTEST, 'WM_NCHITTEST')
GUISetBkColor(0xAA0000)

; Create polygonal region and set it to the window
Local $aPoint[10][2] = [[0, 180], [190, 180], [250, 0], [308, 180], [500, 180], [344, 294], [404, 475], [250, 362], [94, 475], [154, 294]]
Local $hRgn = _WinAPI_CreatePolygonRgn($aPoint)
_WinAPI_SetWindowRgn($hForm, $hRgn, 0)

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $idButton

Func WM_NCHITTEST($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam, $lParam

	Return $HTCAPTION
EndFunc   ;==>WM_NCHITTEST
