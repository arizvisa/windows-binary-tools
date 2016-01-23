#RequireAdmin
; ----------------------------------------------------------------------------
;
; AutoIt Version: 3.1.1
; Author:         Ejoc/JPM/Jon
;
; Script Function:
; Toggle AutoIt beta.
;
; ----------------------------------------------------------------------------

#include <Constants.au3>

Opt("MustDeclareVars", 1)

Local $sInstallDir = RegRead("HKLM\Software\AutoIt v3\AutoIt", "InstallDir")
If $sInstallDir = "" Then $sInstallDir = RegRead("HKLM\Software\Wow6432Node\AutoIt v3\AutoIt", "InstallDir")
If $sInstallDir = "" Then
	MsgBox($MB_SYSTEMMODAL, 'Error', 'Cannot find AutoIt Installation directory')
	Exit
EndIf

Const $sKey = "HKCR\.au3"
Const $sUserChoiceKey = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts"
Local $sCurrentAssoc = RegRead($sKey, "")

; Nuke the UserChoice key which interferes (doesn't work programatically)
RegDelete($sUserChoiceKey & "\.au3\UserChoice")
RegDelete($sUserChoiceKey & "\.a3x\UserChoice")

If RegRead($sUserChoiceKey & "\.au3\UserChoice", "ProgID") <> "" Then
	MsgBox($MB_SYSTEMMODAL, 'Error', "Unable to change the association due to OS restrictions. Please right-click a script and select 'Open with \ Choose default program'.")
	Exit
EndIf

If $sCurrentAssoc = "AutoIt3ScriptBeta" Then
	; Already using beta switch to prod
	RegWrite($sKey, "", "REG_SZ", "AutoIt3Script")
	; make sure that the right AutoItX.dll is installed
	RunWait('regsvr32 /s "' & $sInstallDir & '\AutoItX\AutoItX3.dll"')
	MsgBox($MB_SYSTEMMODAL, "Beta Toggle", "Now using RELEASE version v" & FileGetVersion($sInstallDir & '\AutoIt3.exe') & " of AutoIt", 2)
ElseIf $sCurrentAssoc = "AutoIt3Script" Then
	; Using prod, change to beta
	RegWrite($sKey, "", "REG_SZ", "AutoIt3ScriptBeta")
	; make sure that the right AutoItX.dll is installed
	RunWait('regsvr32 /s "' & $sInstallDir & '\beta\AutoItX\AutoItX3.dll"')
	MsgBox($MB_SYSTEMMODAL, "Beta Toggle", "Now using BETA version v" & FileGetVersion($sInstallDir & '\Beta\AutoIt3.exe') & " of AutoIt", 2)
Else
	MsgBox($MB_SYSTEMMODAL, "Beta Toggle", "AutoIt installation appears to be customised - please manually edit file associations.")
EndIf
