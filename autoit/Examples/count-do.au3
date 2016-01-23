#include <Constants.au3>

;
; AutoIt Version: 3.0
; Language:       English
; Platform:       Win9x/NT
; Author:         Jonathan Bennett (jon at autoitscript dot com)
;
; Script Function:
;   Counts to 5 using a "do" loop

; Prompt the user to run the script - use a Yes/No prompt with the flag parameter set at 4 (see the help file for more details)
Local $iAnswer = MsgBox(BitOR($MB_YESNO, $MB_SYSTEMMODAL), "AutoIt Example", "This script will count to 5 using a 'Do' loop.  Do you want to run it?")

; Check the user's answer to the prompt (see the help file for MsgBox return values)
; If "No" was clicked (7) then exit the script
If $iAnswer = 7 Then
	MsgBox($MB_SYSTEMMODAL, "AutoIt Example", "OK.  Bye!")
	Exit
EndIf

; Set the counter to 1
Local $iCount = 1

; Execute the loop "until" the counter is greater than 5
Do
	; Print the count value
	MsgBox($MB_SYSTEMMODAL, "AutoIt Example", "Count is: " & $iCount)

	; Increase the count by one
	$iCount = $iCount + 1 ; Alternatively $iCount += 1 can be used to increase the value of $iCount by one

Until $iCount > 5

; Finished!
MsgBox($MB_SYSTEMMODAL, "AutoIt Example", "Finished!")
