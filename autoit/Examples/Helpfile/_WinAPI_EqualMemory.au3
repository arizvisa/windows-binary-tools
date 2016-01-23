#include <WinAPISys.au3>

Local $tStruct1 = DllStructCreate('byte[8]')
Local $tStruct2 = DllStructCreate('byte[8]')

_WinAPI_FillMemory($tStruct1, 8, 0x1D)
_WinAPI_FillMemory($tStruct2, 8, 0x1D)

ConsoleWrite('Two structures are equivalent: ' & _WinAPI_EqualMemory($tStruct1, $tStruct2, 8) & @CRLF)
