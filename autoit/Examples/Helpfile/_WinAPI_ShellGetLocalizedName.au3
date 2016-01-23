#include <MsgBoxConstants.au3>
#include <WinAPIShellEx.au3>
#include <WinAPISys.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

Local $aData = _WinAPI_ShellGetLocalizedName(@MyDocumentsDir)
If Not IsArray($aData) Then
	Exit
EndIf

Local $hModule = _WinAPI_LoadLibraryEx($aData[0], $LOAD_LIBRARY_AS_DATAFILE)
ConsoleWrite('Path: ' & $aData[0] & @CRLF)
ConsoleWrite('ID:   ' & $aData[1] & @CRLF)
ConsoleWrite('Name: ' & _WinAPI_LoadString($hModule, $aData[1]) & @CRLF)
_WinAPI_FreeLibrary($hModule)
