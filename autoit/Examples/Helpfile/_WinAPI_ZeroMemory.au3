#include <WinAPISys.au3>

Local $tStruct = DllStructCreate('byte[8]')
ConsoleWrite(DllStructGetData($tStruct, 1) & @CRLF)

_WinAPI_FillMemory($tStruct, 8, 0xAB)
ConsoleWrite(DllStructGetData($tStruct, 1) & @CRLF)

_WinAPI_ZeroMemory($tStruct, 8)
ConsoleWrite(DllStructGetData($tStruct, 1) & @CRLF)
