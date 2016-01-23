#include <WinAPISys.au3>

Local $tStruct1 = DllStructCreate('int')
Local $tStruct2 = DllStructCreate('byte[4]')

DllStructSetData($tStruct1, 1, 0x11223344)

_WinAPI_MoveMemory($tStruct2, $tStruct1, 4)

ConsoleWrite('0x' & Hex(DllStructGetData($tStruct1, 1)) & @CRLF)
ConsoleWrite(DllStructGetData($tStruct2, 1) & @CRLF)
