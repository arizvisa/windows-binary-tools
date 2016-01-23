#include <WinAPIFiles.au3>

Local $aDrive = DriveGetDrive('CDROM')

If IsArray($aDrive) Then
	ConsoleWrite('Open...' & @CRLF)
	_WinAPI_EjectMedia($aDrive[1])
	ConsoleWrite('Tray is open: ' & _WinAPI_IsDoorOpen($aDrive[1]) & @CRLF)
	Sleep(1000)
	ConsoleWrite('Close...' & @CRLF)
	_WinAPI_LoadMedia($aDrive[1])
	ConsoleWrite('Tray is open: ' & _WinAPI_IsDoorOpen($aDrive[1]) & @CRLF)
EndIf
