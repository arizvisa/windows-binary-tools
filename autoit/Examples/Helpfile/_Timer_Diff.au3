#include <Timers.au3>

Example()

Func Example()
	HotKeySet("{ESC}", "_Quit")

	Local $hStarttime = _Timer_Init()
	While 1
		ToolTip(_Timer_Diff($hStarttime))
	WEnd
EndFunc   ;==>Example

Func _Quit()
	Exit
EndFunc   ;==>_Quit
