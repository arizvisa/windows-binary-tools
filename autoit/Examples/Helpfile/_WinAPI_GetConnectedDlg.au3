#include <MsgBoxConstants.au3>
#include <WinAPIDiag.au3>
#include <WinAPIDlg.au3>
#include <WinAPISys.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

If _WinAPI_IsInternetConnected() Then
	ConsoleWrite('Internet is already connected.' & @CRLF)
	Exit
EndIf

; Launch the Get Connected wizard within the calling application to enable Internet connectivity
_WinAPI_GetConnectedDlg(1, 1 + 4)
