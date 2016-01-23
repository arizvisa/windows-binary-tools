#include <MsgBoxConstants.au3>

#comments-start
	MsgBox($MB_SYSTEMMODAL, "", "This won't display ")
	MsgBox($MB_SYSTEMMODAL, "", "nor will this.")
#comments-end

; #cs
MsgBox($MB_SYSTEMMODAL, "", "This will display if '#cs/#ce' are commented out.")
; #ce
