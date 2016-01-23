; Check if the script is already running
; Note: The recommended approach is to use _Singleton from Misc.au3

#include <MsgBoxConstants.au3>

Local $sMyAutoItTitle = "ThisIsSomeUniqueStringThatOtherWindowsWontHave"

If WinExists($sMyAutoItTitle) Then
	; The script is already running

	MsgBox($MB_SYSTEMMODAL, Default, "The script is already running." & @CRLF & @CRLF & _
			"It's PID is: " & WinGetProcess($sMyAutoItTitle))
Else
	; This is the first instance of the script.

	; Set the autoit window title
	AutoItWinSetTitle($sMyAutoItTitle)

	; Run this script again.
	If @Compiled Then
		Run('"' & @ScriptFullPath & '"')
	Else
		Run('"' & @AutoItExe & '" "' & @ScriptFullPath & '"')
	EndIf

	MsgBox($MB_SYSTEMMODAL, Default, "This is the first instance." & @CRLF & @CRLF & _
			"My PID is: " & @AutoItPID)
EndIf
