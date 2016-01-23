#include <Constants.au3>

;
; AutoIt Version: 3.0
; Language:       English
; Platform:       Win9x/NT
; Author:         Jonathan Bennett (jon at autoitscript dot com)
;
; Script Function:
;   Demo of using multiple lines in a message box
;

; Use the @CRLF macro to create a newline in a MsgBox - it is similar to the \n in v2.64
MsgBox($MB_SYSTEMMODAL, "AutoIt Example", "This is line 1" & @CRLF & "This is line 2" & @CRLF & "This is line 3")
