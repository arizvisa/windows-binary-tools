#include <WinAPIShellEx.au3>

Opt('WinTitleMatchMode', 4)

If Not _WinAPI_ShellObjectProperties(@ScriptFullPath) Then Exit

Local $hWnd = WinWaitActive(@ScriptName, '', 3)
If Not $hWnd Then
	Exit
EndIf

While WinExists($hWnd)
	Sleep(100)
WEnd
