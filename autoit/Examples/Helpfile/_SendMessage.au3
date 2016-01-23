#include <MsgBoxConstants.au3>
#include <SendMessage.au3>

Example()

Func Example()
	Local Const $iOff = 2, $iOn = -1

	Opt("WinTitleMatchMode", 4)
	Local $hWnd = WinGetHandle('classname=Progman')
	_ToggleMonitor($hWnd, $iOff)
	Sleep(3000)
	_ToggleMonitor($hWnd, $iOn)
EndFunc   ;==>Example

Func _ToggleMonitor($hWnd, $iOnOff)
	Local Const $WM_SYSCOMMAND = 274
	Local Const $SC_MONITORPOWER = 61808
	_SendMessage($hWnd, $WM_SYSCOMMAND, $SC_MONITORPOWER, $iOnOff)
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "_ToggleMonitor", "_SendMessage Error: " & @error)
		Exit
	EndIf
EndFunc   ;==>_ToggleMonitor
