#include <File.au3>
#include <WinAPIShellEx.au3>

; X64 running support
Local $sWow64 = ""
If @AutoItX64 Then $sWow64 = "\Wow6432Node"

Local $sPath = RegRead('HKLM\SOFTWARE' & $sWow64 & '\AutoIt v3\AutoIt', 'InstallDir')

Local $aList = _FileListToArray($sPath, '*.exe', 1)

If IsArray($aList) Then
	_WinAPI_ShellOpenFolderAndSelectItems($sPath, $aList, 1)
EndIf
