#include <WinAPIMisc.au3>

Local $aVal[5] = [532, 1340, 23506, 2400016, 2400000000]

For $i = 0 To 4
	ConsoleWrite(StringFormat('%10s ' & _WinAPI_StrFormatByteSize($aVal[$i]), $aVal[$i]) & @CRLF)
Next
