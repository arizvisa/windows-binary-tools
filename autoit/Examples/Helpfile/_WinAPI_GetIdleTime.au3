#include <WinAPISys.au3>

For $i = 1 To 5
	ConsoleWrite('Idle time (ms): ' & _WinAPI_GetIdleTime() & @CRLF)
	Sleep(1000)
Next
