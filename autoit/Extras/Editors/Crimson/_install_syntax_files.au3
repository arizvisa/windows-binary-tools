#include <Constants.au3>

#RequireAdmin
;
; AutoIt Version: 3.0
; Language:       English
; Platform:       Win9x/NT
; Author:         Jonathan Bennett <jon at autoitscript dot com>
;
; Script Function:
; Syntax highlighting files installation.
;

; Prompt the user to run the script - use a Yes/No prompt (4 - see help file)
Local $sAnswer = MsgBox(BitOR($MB_YESNO, $MB_SYSTEMMODAL), "Crimson Editor", "This script will attempt to automatically install syntax highlighting files for Crimson Editor.  Run?")
If $sAnswer = 7 Then Exit

; Find an verify the installation directory
Local $sInstalldir = RegRead("HKEY_LOCAL_MACHINE\Software\Crimson System\Crimson Editor", "InstallDir")
If @error Then Error()

Local $sSpec = $sInstalldir & "\spec\"
Local $sLink = $sInstalldir & "\link\"

; Check that both directories exist
If Not FileExists($sSpec) Or Not FileExists($sLink) Then Error()

If Not FileCopy("autoit3.spc", $sSpec, $FC_OVERWRITE) Or Not FileCopy("autoit3.key", $sSpec, $FC_OVERWRITE) Then Error()
If Not FileCopy("extension.au3", $sLink, $FC_OVERWRITE) Then Error()

MsgBox($MB_SYSTEMMODAL, "Crimson Editor", "Installation complete!")

; End of script

Func Error()
	MsgBox($MB_SYSTEMMODAL, "Error", "Unable to find Crimson Editor or error installing the syntax files.  Please try a manual installation.")
	Exit
EndFunc   ;==>Error
