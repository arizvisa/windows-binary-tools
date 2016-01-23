#include <APIDlgConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIDlg.au3>
#include <WinAPISys.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

_WinAPI_ShellOpenWithDlg(@ScriptFullPath, $OAIF_EXEC)
