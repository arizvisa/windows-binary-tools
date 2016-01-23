#include <Constants.au3>

#RequireAdmin
;
; AutoIt Version: 3.0
; Language:       English
; Platform:       Win9x/NT
; Author:         Jonathan Bennett <jon at autoitscript dot com>
; Modified:       poebel at poebel net, jpm
;
; Script Function:
; Syntax highlighting files installation.
;

; Prompt the user to run the script - use a Yes/No prompt (4 - see help file)
Local $sAnswer = MsgBox(BitOR($MB_YESNO, $MB_SYSTEMMODAL), "TextPad v4/5", "This script will attempt to automatically install syntax highlighting and clip library files for TextPad v4/5.  Run?")
If $sAnswer = 7 Then Exit

; Find an verify the installation directory
Local $sTextPadVersion = "5"
Local $sInstalldir = @ProgramFilesDir & "\TextPad " & $sTextPadVersion

; Check that the directory exists (and retry with EnvGet("ProgramFiles(x86) if not)
If Not FileExists($sInstalldir) Then
	$sTextPadVersion = "4"
	$sInstalldir = @ProgramFilesDir & "\TextPad " & $sTextPadVersion
	If Not FileExists($sInstalldir) Then
		$sInstalldir = EnvGet("ProgramFiles(x86)") & "\TextPad " & $sTextPadVersion
		If Not FileExists($sInstalldir) Then
			$sTextPadVersion = "5"
			$sInstalldir = EnvGet("ProgramFiles(x86)") & "\TextPad " & $sTextPadVersion
			If Not FileExists($sInstalldir) Then
				Error()
			EndIf
		EndIf
	EndIf
EndIf

If Not FileCopy(@ScriptDir & "\autoit_v3.syn", $sInstalldir & "\system", $FC_OVERWRITE) Then Error()
If Not FileCopy(@ScriptDir & "\autoit_v3.tcl", $sInstalldir & "\samples", $FC_OVERWRITE) Then Error()

; Now write the reg keys
RegWrite("HKEY_CURRENT_USER\Software\Helios\TextPad " & $sTextPadVersion & "\Document Classes\AutoIt v3", "Type", "REG_DWORD", 2)
RegWrite("HKEY_CURRENT_USER\Software\Helios\TextPad " & $sTextPadVersion & "\Document Classes\AutoIt v3", "Members", "REG_MULTI_SZ", "*.au3")
RegWrite("HKEY_CURRENT_USER\Software\Helios\TextPad " & $sTextPadVersion & "\Document Classes\AutoIt v3", "Properties", "REG_BINARY", "2a002e0061007500330000000000")
RegWrite("HKEY_CURRENT_USER\Software\Helios\TextPad " & $sTextPadVersion & "\Document Classes\AutoIt v3", "SyntaxProps", "REG_BINARY", "01000000")
RegWrite("HKEY_CURRENT_USER\Software\Helios\TextPad " & $sTextPadVersion & "\Document Classes\AutoIt v3", "SyntaxFile", "REG_SZ", "autoit_v3.syn")
RegWrite("HKEY_CURRENT_USER\Software\Helios\TextPad " & $sTextPadVersion & "\Document Classes\AutoIt v3", "WordChars", "REG_SZ", "_$")

$sAnswer = MsgBox(4096 + 4, "TextPad v" & $sTextPadVersion, "Installation complete!" & @LF & @LF & "Do you want to make it the default editor for AutoItV3 scripts ?")
If $sAnswer = 7 Then Exit
RegWrite("HKEY_CLASSES_ROOT\AutoIt3Script\Shell\Edit\Command", "", "REG_SZ", '"' & $sInstalldir & '\TextPad.exe" "%1"')

; End of script

Func Error()
	MsgBox($MB_SYSTEMMODAL, "Error", "Unable to find TextPad or error installing the syntax files.  Please try a manual installation.")
	Exit
EndFunc   ;==>Error
