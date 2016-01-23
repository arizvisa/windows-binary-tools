#include <WinAPIMisc.au3>
#include <WinAPISys.au3>

Local $tStruct1 = DllStructCreate('byte[8]')
_WinAPI_FillMemory($tStruct1, 8, 0x1D)

Local $tStruct2 = _WinAPI_CopyStruct($tStruct1)

ConsoleWrite('Source:      ' & DllStructGetData($tStruct1, 1) & @CRLF)
ConsoleWrite('Destination: ' & DllStructGetData($tStruct2, 1) & @CRLF)
