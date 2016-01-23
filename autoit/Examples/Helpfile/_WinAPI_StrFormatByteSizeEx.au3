#include <WinAPIMisc.au3>

Local $aVal[5] = [532, 1340, 23506, 2400016, 2400000000]

For $i = 0 To 4
	ConsoleWrite(StringFormat('%10s %19s', $aVal[$i], _WinAPI_StrFormatByteSizeEx($aVal[$i])) & @CRLF)
Next
