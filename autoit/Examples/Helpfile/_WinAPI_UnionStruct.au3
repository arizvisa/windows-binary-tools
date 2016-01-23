#include <WinAPIMisc.au3>
#include <WinAPISys.au3>

Local $tStruct1 = DllStructCreate('byte[4]')
_WinAPI_FillMemory($tStruct1, 4, 0xAA)

Local $tStruct2 = DllStructCreate('byte[4]')
_WinAPI_FillMemory($tStruct2, 4, 0xDD)

Local $tStruct3 = _WinAPI_UnionStruct($tStruct1, $tStruct2)

ConsoleWrite('First:  ' & DllStructGetData($tStruct1, 1) & @CRLF)
ConsoleWrite('Second: ' & DllStructGetData($tStruct2, 1) & @CRLF)
ConsoleWrite('Union:  ' & DllStructGetData($tStruct3, 1) & @CRLF)
