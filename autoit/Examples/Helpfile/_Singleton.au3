#include <Misc.au3>
#include <MsgBoxConstants.au3>

If _Singleton("test", 1) = 0 Then
	MsgBox($MB_SYSTEMMODAL, "Warning", "An occurrence of test is already running")
	Exit
EndIf
MsgBox($MB_SYSTEMMODAL, "OK", "the first occurrence of test is running")
