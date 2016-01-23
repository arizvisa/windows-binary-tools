#include <Array.au3>
#include <WinAPI.au3>

ToolTip("test Popup") ; to have at least one popup window

Example()

Func Example()
	Local $aWindows = _WinAPI_EnumWindowsPopup()
	Local $aResult[$aWindows[0][0]][5]
	For $i = 1 To $aWindows[0][0]
		$aResult[$i - 1][0] = $aWindows[$i][0]
		$aResult[$i - 1][1] = $aWindows[$i][1]
		$aResult[$i - 1][2] = WinGetTitle($aWindows[$i][0])
		$aResult[$i - 1][3] = WinGetText($aWindows[$i][0])
		$aResult[$i - 1][4] = WinGetProcess($aWindows[$i][0])
	Next
	_ArrayDisplay($aResult, "_WinAPI_EnumWindowsPopup", Default, Default, Default, Default, "#|Handle|Class|Title|Text|Process")
EndFunc   ;==>Example
