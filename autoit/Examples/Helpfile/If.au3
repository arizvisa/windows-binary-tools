#include <MsgBoxConstants.au3>

; Terminates script if no command-line arguments
If $CmdLine[0] = 0 Then Exit

; Alternative:
If $CmdLine[0] = 0 Then
	Exit
EndIf

MsgBox($MB_SYSTEMMODAL, "", "Script has command-line arguments.")
