#include <WinAPISys.au3>

Local $aData = _WinAPI_GetPerformanceInfo()

ConsoleWrite('Physical Memory (MB)' & @CRLF)
ConsoleWrite('--------------------' & @CRLF)
ConsoleWrite('Total:     ' & Floor($aData[3] / 1024 / 1024) & @CRLF)
ConsoleWrite('Available: ' & Floor($aData[4] / 1024 / 1024) & @CRLF)
ConsoleWrite('Cached:    ' & Floor($aData[5] / 1024 / 1024) & @CRLF)
ConsoleWrite('Free:      ' & Floor($aData[6] / 1024 / 1024) & @CRLF)

ConsoleWrite(@CRLF)

ConsoleWrite('Kernel Memory (MB)' & @CRLF)
ConsoleWrite('--------------------' & @CRLF)
ConsoleWrite('Paged:     ' & Floor($aData[7] / 1024 / 1024) & @CRLF)
ConsoleWrite('Nonpaged:  ' & Floor($aData[8] / 1024 / 1024) & @CRLF)

ConsoleWrite(@CRLF)

ConsoleWrite('System' & @CRLF)
ConsoleWrite('--------------------' & @CRLF)
ConsoleWrite('Handles:   ' & $aData[10] & @CRLF)
ConsoleWrite('Processes: ' & $aData[11] & @CRLF)
ConsoleWrite('Threads:   ' & $aData[12] & @CRLF)
