#include <APIDlgConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIDlg.au3>
#include <WinAPISys.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

Local $aData = _WinAPI_ShellUserAuthenticationDlgEx('Authentication', 'To continue, type a login and password, and then click OK.', '', '', BitOR($CREDUIWIN_ENUMERATE_CURRENT_USER, $CREDUIWIN_CHECKBOX))
If @error Then Exit

Local $aUser = _WinAPI_ParseUserName($aData[0])
If @error Then
	Exit
EndIf

ConsoleWrite('Domain:   ' & $aUser[0] & @CRLF)
ConsoleWrite('User:     ' & $aUser[1] & @CRLF)
ConsoleWrite('Password: ' & $aData[1] & @CRLF)
ConsoleWrite('Save:     ' & $aData[2] & @CRLF)
ConsoleWrite('Package:  ' & $aData[3] & @CRLF)
