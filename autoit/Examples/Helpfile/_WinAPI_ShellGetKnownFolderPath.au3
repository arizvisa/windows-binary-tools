#include <APIShellExConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIShellEx.au3>
#include <WinAPISYs.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

ConsoleWrite(_WinAPI_ShellGetKnownFolderPath($FOLDERID_SendTo, 0, -1) & @CRLF)
ConsoleWrite(_WinAPI_ShellGetKnownFolderPath($FOLDERID_SendTo) & @CRLF)

Local Const $sFOLDERID_wrong = '{8983036C-27C0-404B-8F08-102D10DCFD75}'
ConsoleWrite('"' & _WinAPI_ShellGetKnownFolderPath($sFOLDERID_wrong) & '" @error = ' & @error & ' @extended = 0x' & Hex(@extended) & @CRLF)
