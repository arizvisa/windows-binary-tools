#include <WinAPIMisc.au3>

Local $aVal[3] = [23506, 2400016, 2400000000]

For $i = 0 To 2
	ConsoleWrite(StringFormat('%10s %12s', $aVal[$i], _WinAPI_StrFormatKBSize($aVal[$i])) & @CRLF)
Next
