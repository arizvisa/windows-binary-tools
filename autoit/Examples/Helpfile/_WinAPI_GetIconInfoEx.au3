#include <MsgBoxConstants.au3>
#include <WinAPIRes.au3>
#include <WinAPISys.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

Local $hInstance = _WinAPI_LoadLibraryEx(@AutoItExe, $LOAD_LIBRARY_AS_DATAFILE)
Local $hIcon = _WinAPI_LoadImage($hInstance, 99, $IMAGE_ICON, 0, 0, $LR_DEFAULTSIZE)
Local $aInfo = _WinAPI_GetIconInfoEx($hIcon)
If IsArray($aInfo) Then
	ConsoleWrite('Handle: ' & $hIcon & @CRLF)
	ConsoleWrite('Path:   ' & $aInfo[6] & @CRLF)
	ConsoleWrite('ID:     ' & $aInfo[5] & @CRLF)
	For $i = 3 To 4
		_WinAPI_DestroyIcon($aInfo[$i])
	Next
EndIf
_WinAPI_FreeLibrary($hInstance)
_WinAPI_DestroyIcon($hIcon)
