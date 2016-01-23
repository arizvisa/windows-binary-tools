#include <MsgBoxConstants.au3>

Local $iTimeout = 10

; Display a message box with a nested variable in its text.
MsgBox($MB_SYSTEMMODAL, "Title", "This message box will timeout after " & $iTimeout & " seconds or select the OK button.", $iTimeout)
