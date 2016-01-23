#include <MsgBoxConstants.au3>

; AutoITCOM 3.1.0
;
; Test file
;
; Test enumerating groups using ADSI
;
; See also: http://msdn.microsoft.com/library/en-us/adsi/adsi/adsi_winnt_provider.asp

; Note: opening a local WINNT object consumes a lot of time.
; Microsoft advises using WMI for these purposes.
; But on systems that do not support WMI, you don't have this alternative.

SplashTextOn("WINNT ADSI Test", "Opening local WINNT Object..this might take a few seconds...", -1, 40)

; Initialize a COM Error Handler
Global $g_nComError = 0, $g_oMyErr = ObjEvent("AutoIt.Error", "MyErrFunc")

; Open ADSI
Local $oColGroups = ObjGet("WinNT://" & @ComputerName)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "AutoItCOM ADSI Test", "Failed to open WinNT://. Error code: " & Hex(@error, 8))
	Exit
EndIf

SplashOff()

; Note: this is NOT the same as:  GetObject("WinNT://<computer name>/,group")

Local $aArray[1] ; Our filter array

$aArray[0] = "group" ; We only include 'groups' in this filter

$oColGroups.Filter = $aArray ; Apply filter

If Not IsObj($oColGroups) Then
	MsgBox($MB_SYSTEMMODAL, "Grouptest", "$oColGroups is not an object")
	Exit
EndIf

Local $sDisplay = "Groups defined on this computer: " & @CRLF ; To display the results

For $oGroup In $oColGroups
	$sDisplay = $sDisplay & $oGroup.Name & @TAB
Next

MsgBox($MB_SYSTEMMODAL, "WINNT ADSI Test", $sDisplay)

Exit

; ---------------

Func MyErrFunc()
	Local $sHexnum = Hex($g_oMyErr.number, 8)
	MsgBox($MB_SYSTEMMODAL, "", "We intercepted a COM Error!!" & @CRLF & @CRLF & _
			"err.description is: " & $g_oMyErr.description & @CRLF & _
			"err.windescription is: " & $g_oMyErr.windescription & @CRLF & _
			"err.lastdllerror is: " & $g_oMyErr.lastdllerror & @CRLF & _
			"err.scriptline is: " & $g_oMyErr.scriptline & @CRLF & _
			"err.number is: " & $sHexnum & @CRLF & _
			"err.source is: " & $g_oMyErr.source & @CRLF & _
			"err.helpfile is: " & $g_oMyErr.helpfile & @CRLF & _
			"err.helpcontext is: " & $g_oMyErr.helpcontext _
			)

	$g_nComError = $g_oMyErr.number
EndFunc   ;==>MyErrFunc
