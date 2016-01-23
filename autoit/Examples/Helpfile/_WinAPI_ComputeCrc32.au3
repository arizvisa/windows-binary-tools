#include <WinAPISys.au3>

Local $tData = DllStructCreate('byte[4096]')

ConsoleWrite(Hex(_WinAPI_ComputeCrc32($tData, 4096)) & @CRLF)

_WinAPI_FillMemory($tData, 4096, Random(0, 255, 1))

ConsoleWrite(Hex(_WinAPI_ComputeCrc32($tData, 4096)) & @CRLF)

_WinAPI_ZeroMemory($tData, 4096)

ConsoleWrite(Hex(_WinAPI_ComputeCrc32($tData, 4096)) & @CRLF & @CRLF)

ConsoleWrite('Invalid pointer -> ' & _WinAPI_ComputeCrc32(0, 4) & ' @error = ' & @error & ' @extended = 0x' & Hex(@extended) & @CRLF)
