#include <MsgBoxConstants.au3>
#include <WinAPIDiag.au3>
#include <WinAPIFiles.au3>
#include <WinAPISys.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

; Enable "SeCreateSymbolicLinkPrivilege" privilege to create a symbolic links
Local $hToken = _WinAPI_OpenProcessToken(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
Local $aAdjust
_WinAPI_AdjustTokenPrivileges($hToken, $SE_CREATE_SYMBOLIC_LINK_NAME, $SE_PRIVILEGE_ENABLED, $aAdjust)
If @error Or @extended Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'You do not have the required privileges.')
	Exit
EndIf

; Create symbolic link to the directory where this file is located with prefix "@" on your Desktop
If Not _WinAPI_CreateSymbolicLink(@DesktopDir & '\' & StringRegExpReplace(@ScriptDir, '^.*\\', '@'), @ScriptDir, 1) Then
	_WinAPI_ShowLastError()
EndIf

; Restore "SeCreateSymbolicLinkPrivilege" privilege by default
_WinAPI_AdjustTokenPrivileges($hToken, $aAdjust, 0, $aAdjust)
_WinAPI_CloseHandle($hToken)
