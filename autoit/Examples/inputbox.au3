#include <Constants.au3>

;
; AutoIt Version: 3.0
; Language:       English
; Platform:       Win9x/NT
; Author:         Jonathan Bennett (jon at autoitscript dot com)
;
; Script Function:
;   Demonstrates the InputBox, looping and the use of @error.
;

; Prompt the user to run the script - use a Yes/No prompt with the flag parameter set at 4 (see the help file for more details)
Local $iAnswer = MsgBox(BitOR($MB_YESNO, $MB_SYSTEMMODAL), "AutoIt Example (English Only)", "This script will open an input box and get you to type in some text.  Do you want to run it?")

; Check the user's answer to the prompt (see the help file for MsgBox return values)
; If "No" was clicked (7) then exit the script
If $iAnswer = 7 Then
	MsgBox($MB_SYSTEMMODAL, "AutoIt", "OK.  Bye!")
	Exit
EndIf

; Loop around until the user gives a valid "autoit" answer. This is not case-sensitive, therefore AutoIt and AuToIT are acceptable values as well
Local $iLoop = 1, $sText = ""
While $iLoop = 1
	$sText = InputBox("AutoIt Example", "Please type in the word ""autoit"" and click OK")
	If @error = 1 Then
		MsgBox($MB_SYSTEMMODAL, "Error", "You pressed 'Cancel' - try again!")
	Else
		; They clicked OK, but did they type the right thing?
		If $sText <> "autoit" Then ; This is not case-sensitive, therefore AutoIt and AuToIT are acceptable values as well
			MsgBox($MB_SYSTEMMODAL, "Error", "You typed in the wrong thing - try again!")
		Else
			$iLoop = 0 ; Exit the loop - ExitLoop would have been an alternative too
		EndIf
	EndIf
WEnd

; Print the success message
MsgBox($MB_SYSTEMMODAL, "AutoIt Example", "You typed in the correct word!  Congrats.")

; Finished!
