#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Local $sFile = @DesktopDir & '\' & StringRegExpReplace(_WinAPI_PathFindFileName(@ScriptName), '\A_+', '@')

; Create hard link to the current file with prefix "@" on your Desktop
If Not _WinAPI_CreateHardLink($sFile, @ScriptFullPath) Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Unable to create hard link.')
	Exit
EndIf

; Enumerate all hard links to the file
Local $aData = _WinAPI_EnumHardLinks($sFile)

_ArrayDisplay($aData, '_WinAPI_EnumHardLinks')

FileDelete($sFile)
