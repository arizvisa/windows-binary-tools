#include <Date.au3>
#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

; Under Vista the Windows API "SetSystemTimeAdjustment" may be rejected due to system security

Example()

Func Example()
	Local $aInfo

	; Open the clock so we can watch the fun
	Run("RunDll32.exe shell32.dll,Control_RunDLL timedate.cpl")
	WinWaitActive("[CLASS:#32770]")

	; Get current time adjustments
	$aInfo = _Date_Time_GetSystemTimeAdjustment()

	; Slow down clock
	If Not _Date_Time_SetSystemTimeAdjustment($aInfo[1] / 10, False) Then
		MsgBox($MB_SYSTEMMODAL, "Error", "System clock cannot be DOWN" & @CRLF & @CRLF & _WinAPI_GetLastErrorMessage())
		Exit
	EndIf
	MsgBox($MB_SYSTEMMODAL, "Information", "Slowing down system clock", 2)

	Sleep(5000)

	; Speed up clock
	If Not _Date_Time_SetSystemTimeAdjustment($aInfo[1] * 10, False) Then
		MsgBox($MB_SYSTEMMODAL, "Error", "System clock cannot be UP" & @CRLF & @CRLF & _WinAPI_GetLastErrorMessage())
	EndIf
	MsgBox($MB_SYSTEMMODAL, "Information", "Speeding up system clock", 2)

	Sleep(5000)

	; Reset time adjustment
	If Not _Date_Time_SetSystemTimeAdjustment($aInfo[1], True) Then
		MsgBox($MB_SYSTEMMODAL, "Error", "System clock cannot be RESET" & @CRLF & @CRLF & _WinAPI_GetLastErrorMessage())
	Else
		MsgBox($MB_SYSTEMMODAL, "Information", "System clock restored")
	EndIf
EndFunc   ;==>Example
