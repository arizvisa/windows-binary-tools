#include <Date.au3>

Local $iMsg = "Test record"
FileWriteLine(@TempDir & "\Pgm.log", _NowCalcDate() & " :" & $iMsg)
