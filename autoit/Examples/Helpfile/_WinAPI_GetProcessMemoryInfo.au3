#include <WinAPIProc.au3>

Local $aData = _WinAPI_GetProcessMemoryInfo()

ConsoleWrite('Number of page faults: ' & $aData[0] & @CRLF)
ConsoleWrite('Peak working set size: ' & $aData[1] & ' bytes' & @CRLF)
ConsoleWrite('Current working set size: ' & $aData[2] & ' bytes' & @CRLF)
ConsoleWrite('Peak paged pool usage: ' & $aData[3] & ' bytes' & @CRLF)
ConsoleWrite('Current paged pool usage: ' & $aData[4] & ' bytes' & @CRLF)
ConsoleWrite('Peak nonpaged pool usage: ' & $aData[5] & ' bytes' & @CRLF)
ConsoleWrite('Current nonpaged pool usage: ' & $aData[6] & ' bytes' & @CRLF)
ConsoleWrite('Current space allocated for the pagefile: ' & $aData[7] & ' bytes' & @CRLF)
ConsoleWrite('Peak space allocated for the pagefile: ' & $aData[8] & ' bytes' & @CRLF)
ConsoleWrite('Current private space: ' & $aData[9] & ' bytes' & @CRLF)
