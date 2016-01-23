#include <MsgBoxConstants.au3>
#include <Timers.au3>

; Mouse/Keyboard action during this 10 sec delay will change reported idle time
Sleep(10 * 1000); 10sec

Local $iIdleTime = _Timer_GetIdleTime()

MsgBox($MB_SYSTEMMODAL, "_Timer_GetIdleTime", "Idle time = " & $iIdleTime & "ms")
