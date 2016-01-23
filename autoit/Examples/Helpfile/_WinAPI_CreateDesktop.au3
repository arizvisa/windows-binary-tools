#include <APIProcConstants.au3>
#include <APISysConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPI.au3>
#include <WinAPIProc.au3>
#include <WinAPISys.au3>

; Retrieve a handle to the current desktop and create a new desktop named "MyDesktop"
Local $hPrev = _WinAPI_GetThreadDesktop(_WinAPI_GetCurrentThreadId())
Local $hDesktop = _WinAPI_CreateDesktop('MyDesktop', BitOR($DESKTOP_CREATEWINDOW, $DESKTOP_SWITCHDESKTOP))
If Not $hDesktop Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Unable to create desktop.')
	Exit
EndIf

; Switch to the newly created desktop
_WinAPI_SwitchDesktop($hDesktop)

; Run "calc.exe" on "MyDesktop" and wait until a process will not be closed by user
Local $pText = _WinAPI_CreateString('MyDesktop')
Local $tProcess = DllStructCreate($tagPROCESS_INFORMATION)
Local $tStartup = DllStructCreate($tagSTARTUPINFO)
DllStructSetData($tStartup, 'Size', DllStructGetSize($tStartup))
DllStructSetData($tStartup, 'Desktop', $pText)
If _WinAPI_CreateProcess('', @SystemDir & '\calc.exe', 0, 0, 0, $CREATE_NEW_PROCESS_GROUP, 0, 0, $tStartup, $tProcess) Then
	ProcessWaitClose(DllStructGetData($tProcess, 'ProcessID'))
EndIf

; Switch to previous desktop and close "MyDesktop"
_WinAPI_SwitchDesktop($hPrev)
_WinAPI_CloseDesktop($hDesktop)

; Free memory allocated for a string
_WinAPI_FreeMemory($pText)
