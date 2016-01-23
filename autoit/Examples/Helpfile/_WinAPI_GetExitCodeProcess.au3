#include <ProcessConstants.au3>
#include <WinAPIProc.au3>
#include <WinAPISys.au3>

; _WinAPI_CreateProcess() will be the best solution
Local $iPID = Run('cmd.exe /k')
If Not $iPID Then
	Exit
EndIf

; Note, immediately open the process
Local $hProcess
If _WinAPI_GetVersion() >= 6.0 Then
	$hProcess = _WinAPI_OpenProcess($PROCESS_QUERY_LIMITED_INFORMATION, 0, $iPID)
Else
	$hProcess = _WinAPI_OpenProcess($PROCESS_QUERY_INFORMATION, 0, $iPID)
EndIf
If Not $hProcess Then
	Exit
EndIf

; Wait until the process exists, try enter "exit 6"
While ProcessExists($iPID)
	Sleep(100)
WEnd

ConsoleWrite('Exit code: ' & _WinAPI_GetExitCodeProcess($hProcess) & @CRLF)

_WinAPI_CloseHandle($hProcess)
