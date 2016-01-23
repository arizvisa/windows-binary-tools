; =======================================================================
; Original idea by w0uter
; Modified by steve8tch
; 2008 updated to work with newer PCRE implemetation
; removed use of message boxes and splash screens
; created status bar to display messages
; added timer
; 2011 updated
; fixes:
; Help file button did not work with compiled scripts
; x64 OS aware.
; Different separator charactor used in GUICtrlSetData (thanks FichteFoll)
; Display formating fixed when number of results from StringRegExp = 9, or 99, or 999 etc (thanks FichteFoll)
; =======================================================================
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GuiConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <StaticConstants.au3>
#include <StringConstants.au3>
#include <WindowsConstants.au3>

Global Const $g_sSep = Chr(11) ; --> 0x0B = VT - use as a separator for use in the combo control. By default this uses a "|" and this charactor is likely to be used in a pattern file
Opt("GUIDataSeparatorChar", $g_sSep)
Global $g_sInitialDir = @ScriptDir
Global Const $GREEN = 0xAAFFD5
Global Const $GREY = 0xD4D0C8
Global Const $RED = 0xFF8888
Global Const $BLACK = 0x000000
Global Const $BLUE = 0x0000FF
Global Const $SOFTYELLOW = 0xFBFFC6
Global Const $YELLOW = 0xFFFC8A
Global $g_idStringToTest ; $g_idStringToTest holds the currently selected tab for the input string to be tested (ie from the edit box or from the text file)
; results from StringRegExp come in 3 forms: a single string (rtn flag 0), a single array (rtn flag 1,2,3) or an array of arrays (rtn flag 4)
Global $g_bResultTrueFalseExpected = False
Global $g_bArrayOfArraysExpected = False
Global $g_sPatterns = readDatFile()
GUICreate("StringRegExp Original idea -by w0uter, modified Steve8tch", 550, 596, (@DesktopWidth - 550) / 2, (@DesktopHeight - 570) / 2)
GUICtrlCreateGroup("The pattern   -  $ptn", 10, 210, 530, 60)
GUICtrlCreateGroup("Output", 145, 280, 395, 280)
GUICtrlCreateGroup("       Return Flag", 10, 280, 125, 120)
GUICtrlCreateGroup("           Offset", 10, 410, 125, 50)
GUICtrlCreateGroup("@error     @extended", 10, 470, 125, 50)
Global $g_idRadio_0 = GUICtrlCreateRadio("Match", 15, 300, 115, 18)
Global $g_idRadio_1 = GUICtrlCreateRadio("ArrayMatch", 15, 318, 115, 18)
Global $g_idRadio_2 = GUICtrlCreateRadio("ArrayFullMatch", 15, 336, 115, 18)
Global $g_idRadio_3 = GUICtrlCreateRadio("ArrayGlobalMatch", 15, 354, 115, 18)
Global $g_idRadio_4 = GUICtrlCreateRadio("ArrayGlobalFullMatch", 15, 372, 115, 18)
GUICtrlSetState($g_idRadio_1, $GUI_CHECKED)

Local $idTab = GUICtrlCreateTab(10, 10, 530, 190)
Global $idTabitem1 = GUICtrlCreateTabItem("Copy and Paste the text to check - $str")
Local $idInputEditBox = GUICtrlCreateEdit("", 20, 40, 510, 150, BitOR($ES_WANTRETURN, $WS_VSCROLL, $WS_HSCROLL, $ES_AUTOVSCROLL, $ES_AUTOHSCROLL))
GUICtrlSetBkColor($idInputEditBox, $SOFTYELLOW)
Global $idTabitem2 = GUICtrlCreateTabItem("Load text from File")
Local $idBrowse = GUICtrlCreateButton("Browse for file", 20, 40, 100, 20)
Global $g_idPathToInputFile = GUICtrlCreateEdit("", 130, 40, 400, 20, BitOR($ES_WANTRETURN, $WS_HSCROLL, $ES_AUTOHSCROLL))
Global $g_idInputFromFile = GUICtrlCreateEdit("", 20, 70, 510, 120, BitOR($ES_WANTRETURN, $WS_VSCROLL, $WS_HSCROLL, $ES_AUTOVSCROLL, $ES_AUTOHSCROLL))
GUICtrlSetBkColor($g_idInputFromFile, $SOFTYELLOW)
GUICtrlCreateTabItem("");
Global $g_idOut = GUICtrlCreateEdit("", 155, 296, 375, 262, BitOR($ES_WANTRETURN, $WS_VSCROLL, $WS_HSCROLL, $ES_AUTOVSCROLL, $ES_AUTOHSCROLL))
GUICtrlSetBkColor($g_idOut, $SOFTYELLOW)
Global $g_idPattern = GUICtrlCreateCombo("", 70, 230, 430, 30)
GUICtrlSetFont($g_idPattern, 14, -1, -1, "Arial")
GUICtrlSetColor($g_idPattern, $BLUE)
GUICtrlSetBkColor($g_idPattern, $YELLOW)
GUICtrlSetData($g_idPattern, $g_sPatterns, "(.*)")
Global $idDoPtnAdd = GUICtrlCreateButton("Add", 504, 225, 30, 18)
Local $idDoPtnDel = GUICtrlCreateButton("Del", 504, 245, 30, 18)
Local $idTest = GUICtrlCreateButton("Test", 20, 235, 40, 20, $BS_DEFPUSHBUTTON)
Global $g_idOffset = GUICtrlCreateInput("1", 40, 430, 60, 20)
Global $g_idErr = GUICtrlCreateInput("", 20, 490, 40, 20, $ES_READONLY)
Global $g_idExt = GUICtrlCreateInput("", 70, 490, 50, 20, $ES_READONLY)
Local $id_Help = GUICtrlCreateButton("StringRegExp HELP", 10, 530, 120, 30)
; Global $hGui_Exit = GUICtrlCreateButton("EXIT", 10, 530, 55, 30)
Global $g_idTimerDisplay = GUICtrlCreateLabel("Time (ms)", 3, 573, 142, 20, $SS_SUNKEN)
Global $g_idStatusBar = GUICtrlCreateLabel("Status..", 150, 573, 395, 20, $SS_SUNKEN)
$g_idStringToTest = $idInputEditBox ; default - read the string to be tested from the edit box
; setup tool tips
; GUICtrlSetTip required IE version 5+
If Number(StringLeft(RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer", "Version"), 1)) > 4 Then
	GUICtrlSetTip($g_idRadio_0, "Returns 1 (matched) or 0 (no match)", "Return Flag= 0", 1, 1)
	GUICtrlSetTip($g_idRadio_1, "Returns an array containing the matches.", "Return Flag = 1", 1, 1)
	GUICtrlSetTip($g_idRadio_2, "Returns the full matched string AND an array containing the matches (Perl / PHP style).", "Return Flag = 2", 1, 1)
	GUICtrlSetTip($g_idRadio_3, "Returns an array containing the global matches.", "Return Flag = 3", 1, 1)
	GUICtrlSetTip($g_idRadio_4, "Returns an array of arrays containing the full matched strings AND global matches. (Perl / PHP style).", "Return Flag = 4", 1, 1)
	GUICtrlSetTip($g_idOffset, "[optional] The string position to start the match (starts at 1) The default is 1.", "Offset option", 1, 1)
Else
	GUICtrlSetTip($g_idRadio_0, "Returns 1 (matched) or 0 (no match)")
	GUICtrlSetTip($g_idRadio_1, "Returns an array containing the matches.")
	GUICtrlSetTip($g_idRadio_2, "Returns the full matched string AND an array containing the matches (Perl / PHP style).")
	GUICtrlSetTip($g_idRadio_3, "Returns an array containing the global matches.")
	GUICtrlSetTip($g_idRadio_4, "Returns an array of arrays containing the full matched strings AND global matches. (Perl / PHP style).")
	GUICtrlSetTip($g_idOffset, "[optional] The string position to start the match (starts at 1) The default is 1.")
EndIf

GUISetState(@SW_SHOW)
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
		Case $idTest
			doStringRegExpTest()
		Case $idBrowse
			doBrowseForFile()
		Case $idTab
			If GUICtrlRead($idTab) = 0 Then
				$g_idStringToTest = $idInputEditBox
			Else
				$g_idStringToTest = $g_idInputFromFile
			EndIf
		Case $idDoPtnAdd
			doPtnAdd(GUICtrlRead($g_idPattern))
		Case $idDoPtnDel
			doPtnDel(GUICtrlRead($g_idPattern))
		Case $id_Help
			doDisplayHelp()
		Case Else
			;;
	EndSwitch
WEnd

Func doStringRegExpTest()
	Local $aA, $aB ;use for arrays
	Local $i, $j ; use for stepping through arrays
	Local $c ;  counter
	Local $hTimer, $t ; use for timing
	Local $iErr, $iExt ; use to hold result of @error and @extended
	Local $sResult = "" ; use to hold result
	Local $iStrLgth ; use to the string length of the number of results expected. (eg Use in the StringFormat function
	Local $x, $y ; local vars.
	GUICtrlSetData($g_idOut, "")
	GUICtrlSetData($g_idStatusBar, "Performing test..... please wait.")
	GUICtrlSetBkColor($g_idStatusBar, $GREEN)
	;set up timer
	$hTimer = TimerInit()
	$aA = StringRegExp(GUICtrlRead($g_idStringToTest), GUICtrlRead($g_idPattern), getReturnFlag(), getOffset())
	$iErr = @error
	$iExt = @extended
	$t = TimerDiff($hTimer)
	GUICtrlSetData($g_idTimerDisplay, $t & "  ms")
	GUICtrlSetData($g_idErr, $iErr)
	GUICtrlSetData($g_idExt, $iExt)
	Select
		Case $iErr = 0
			GUICtrlSetData($g_idStatusBar, "Valid pattern - updating display.   Please wait....")
			GUICtrlSetBkColor($g_idStatusBar, $GREEN)
		Case $iErr = 1
			GUICtrlSetData($g_idStatusBar, "Array is invalid. No matches")
			GUICtrlSetBkColor($g_idStatusBar, $RED)
		Case $iErr = 2
			GUICtrlSetData($g_idStatusBar, "Bad pattern, (array is invalid). @extended = offset of error in pattern.")
			GUICtrlSetBkColor($g_idStatusBar, $RED)
	EndSelect
	If $iErr = 0 Then
		$x = UBound($aA)
		If $g_bArrayOfArraysExpected Then
			$y = UBound($aA[0])
			$x *= $y
		EndIf
		$iStrLgth = StringLen(String($x - 1))
		If $g_bArrayOfArraysExpected Then ; results -> array of arrays expected
			$c = 0 ; use $c as a counter to help display the results
			If UBound($aA) Then
				For $i = 0 To UBound($aA) - 1
					$aB = $aA[$i]
					For $j = 0 To UBound($aB) - 1
						$sResult &= StringFormat("%0" & $iStrLgth & "i", $c) & ' => ' & $aB[$j] & @CRLF
						$c += 1
					Next
					$sResult &= @CRLF
				Next
				GUICtrlSetData($g_idOut, $sResult)
				GUICtrlSetData($g_idStatusBar, "Complete")
			EndIf
		ElseIf $g_bResultTrueFalseExpected Then ; result string expected
			If $aA = 1 Then
				$sResult &= "1   <-- SUCCESS, matches found" & @CRLF
			Else
				$sResult &= "0   <-- FAIL, no matches found" & @CRLF
			EndIf
			GUICtrlSetData($g_idOut, $sResult)
			GUICtrlSetData($g_idStatusBar, "Complete")
		Else ; a single array expected
			If UBound($aA) Then
				For $i = 0 To UBound($aA) - 1
					$sResult &= StringFormat("%0" & $iStrLgth & "i", $i) & ' => ' & $aA[$i] & @CRLF
				Next
				GUICtrlSetData($g_idOut, $sResult)
				GUICtrlSetData($g_idStatusBar, "Complete")
			EndIf
		EndIf
	EndIf
EndFunc   ;==>doStringRegExpTest

Func getReturnFlag()
	$g_bArrayOfArraysExpected = False
	$g_bResultTrueFalseExpected = False
	Switch $GUI_CHECKED
		Case GUICtrlRead($g_idRadio_0)
			$g_bResultTrueFalseExpected = True
			Return $STR_REGEXPMATCH
		Case GUICtrlRead($g_idRadio_1)
			Return $STR_REGEXPARRAYMATCH
		Case GUICtrlRead($g_idRadio_2)
			Return $STR_REGEXPARRAYFULLMATCH
		Case GUICtrlRead($g_idRadio_3)
			Return $STR_REGEXPARRAYGLOBALMATCH
		Case GUICtrlRead($g_idRadio_4)
			$g_bArrayOfArraysExpected = True
			Return $STR_REGEXPARRAYGLOBALFULLMATCH
	EndSwitch
EndFunc   ;==>getReturnFlag

Func getOffset()
	Local $x
	$x = Int(GUICtrlRead($g_idOffset))
	If @error Then
		Return 1
	Else
		Return $x
	EndIf
EndFunc   ;==>getOffset

Func doBrowseForFile()
	Local $sFilePath, $sFileTxt
	$sFilePath = FileOpenDialog("Select text file to test", $g_sInitialDir, "Text files (*.*)", 1)
	$g_sInitialDir = StringTrimRight($sFilePath, StringInStr($sFilePath, "\", "-1"))
	GUICtrlSetData($g_idStatusBar, "Loading file..")
	GUICtrlSetBkColor($g_idStatusBar, $GREEN)
	GUICtrlSetData($g_idPathToInputFile, $sFilePath)
	$sFileTxt = FileRead($sFilePath)
	GUICtrlSetData($g_idStatusBar, "File loaded... updating display")
	GUICtrlSetData($g_idInputFromFile, $sFileTxt)
	GUICtrlSetData($g_idStatusBar, "")
	GUICtrlSetBkColor($g_idStatusBar, $GREY)
EndFunc   ;==>doBrowseForFile

Func readDatFile()
	Local $sDat, $sOut = ""
	Local $sHeader = "[do not delete this file - Patterns are listed below]" & @CRLF
	Local $sDatFile = @AppDataDir & "\StringRegExpGUIPattern.dat"
	If FileExists($sDatFile) = 0 Then
		$sDat = $sHeader & "(.*)"
		FileWrite($sDatFile, $sDat)
		$sOut = "(.*)"
	Else
		$sDat = FileRead($sDatFile)
		$sDat = StringReplace($sDat, $sHeader, "") ; strip out header line
		;Strip out any leading or trailing @CRLF
		If StringLeft($sDat, 2) = @CRLF Then $sDat = StringTrimLeft($sDat, 2)
		If StringRight($sDat, 2) = @CRLF Then $sDat = StringTrimRight($sDat, 2)
		If $sDat <> "" Then ; we should have 1 or more patterns
			$sOut = StringReplace($sDat, @CRLF, $g_sSep)
		Else
			FileWrite($sDatFile, $sHeader & "(.*)")
			$sOut = "(.*)"
		EndIf
	EndIf
	Return $sOut
EndFunc   ;==>readDatFile

Func doPtnDel($x)
	Local $sDat
	Local $sDatFile = @AppDataDir & "\StringRegExpGUIPattern.dat"
	$sDat = FileRead($sDatFile)
	;now find and remove this entry from the dat file
	$sDat = StringReplace($sDat, $x, "")
	;If $x was in the middle of the dat file - we will now need to find and remove any double @CRLF entries
	$sDat = StringReplace($sDat, @CRLF & @CRLF, @CRLF)
	;If $x was at the beginning or the end of the file - we now need to stop off a leading or trailing @CRLF entry
	If StringLeft($sDat, 2) = @CRLF Then $sDat = StringTrimLeft($sDat, 2)
	If StringRight($sDat, 2) = @CRLF Then $sDat = StringTrimRight($sDat, 2)
	;Now delete the previous dat file and create a new one
	If FileDelete($sDatFile) Then
		FileWrite($sDatFile, $sDat)
	Else
		MsgBox($MB_SYSTEMMODAL, "***ERROR**", "Failed to delete  entry from the dat file" & @CRLF & _
				"Reason: Failed to delete old file.")
	EndIf
	;Now read in new dat file
	$g_sPatterns = readDatFile()
	GUICtrlSetData($g_idPattern, $g_sSep & $g_sPatterns, "(.*)")
EndFunc   ;==>doPtnDel

Func doPtnAdd($x)
	Local $sDat
	Local $sDatFile = @AppDataDir & "\StringRegExpGUIPattern.dat"
	$sDat = FileRead($sDatFile)
	;now add this entry fto the end of the dat file
	$sDat &= @CRLF & $x
	;Now delete the previous dat file and create a new one
	If FileDelete($sDatFile) Then
		FileWrite($sDatFile, $sDat)
	Else
		MsgBox($MB_SYSTEMMODAL, "***ERROR**", "Failed to delete  entry from the dat file" & @CRLF & _
				"Reason: Failed to delete old file.")
	EndIf
	;Now read in new dat file
	$g_sPatterns = readDatFile()
	GUICtrlSetData($g_idPattern, $g_sSep & $g_sPatterns, $x)
EndFunc   ;==>doPtnAdd

Func doDisplayHelp()
	Local $iErr = 0
	If @Compiled = 0 Then
		Local $sPathToHelpFile = StringLeft(@AutoItExe, StringInStr(@AutoItExe, "\", 0, -1))
		Run($sPathToHelpFile & "AutoIt3Help.exe StringRegExp")
		$iErr = @error
	Else
		; X64 running support
		Local $sWow64 = ""
		If @AutoItX64 Then $sWow64 = "\Wow6432Node"

		;Try and file to help file (if available at all)
		;get AutoIt install dir
		Local $sPathToAutoIt = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt", "InstallDir")
		$iErr = @error

		If $iErr = 0 Then
			Run($sPathToAutoIt & "\AutoIt3Help.exe StringRegExp")
			$iErr = @error
		EndIf
	EndIf
	If $iErr Then MsgBox($MB_SYSTEMMODAL, "error", "Cannot find help file - sorry")
EndFunc   ;==>doDisplayHelp
