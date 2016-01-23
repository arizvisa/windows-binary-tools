#include <MsgBoxConstants.au3>

Local $hTimer = TimerInit() ; Begin the timer and store the handle in a variable.
Sleep(3000) ; Sleep for 3 seconds.
Local $fDiff = TimerDiff($hTimer) ; Find the difference in time from the previous call of TimerInit. The variable we stored the TimerInit handlem is passed as the "handle" to TimerDiff.
MsgBox($MB_SYSTEMMODAL, "Time Difference", $fDiff)
