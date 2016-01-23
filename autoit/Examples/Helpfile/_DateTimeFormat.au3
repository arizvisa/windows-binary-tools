#include <Date.au3>
#include <MsgBoxConstants.au3>

; Show current date/time in the pc's format
MsgBox($MB_SYSTEMMODAL, "Pc Long format", _DateTimeFormat(_NowCalc(), 1))
MsgBox($MB_SYSTEMMODAL, "Pc Short format", _DateTimeFormat(_NowCalc(), 2))
