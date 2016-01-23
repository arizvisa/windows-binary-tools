#include <MsgBoxConstants.au3>

; COM Test file
;
; Error Event test using Winnt ADSI
;
; This will cause an ErrorEvent on most computers.

; Initialize my Error function
Local $oErrObj = ObjEvent("AutoIt.Error", "MyErrFunc")

; Open Winnt object on local machine, this might take a few seconds time.
Local $oContainer = ObjGet("WinNT://" & @ComputerName)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "AutoItCOM Test", "Failed to open WinNT://. Error code: " & Hex(@error, 8))
	Exit
EndIf

Local $sUser = "CBrooke"
Local $oUser = $oContainer.Create("User", $sUser)

; This will only succeed on computers where local user passwords are allowed to be empty.
$oUser.SetInfo()

; The line below should throw an Error after a short timeout,
; because "domain" and "MyGroup" do not exist.

Local $oGroup = ObjGet("WinNT://domain/MyGroup, group")

If @error Then
	MsgBox($MB_SYSTEMMODAL, "", "error opening object $oGroup, error code: " & @error)
	Exit
Else
	$oGroup.Add($oUser.ADsPath)
	$oGroup.SetInfo()
EndIf

Exit

; ----------------

Func MyErrFunc($oErrObj)
	Local $sHexnum = Hex($oErrObj.number, 8)

	MsgBox($MB_SYSTEMMODAL, "", "We intercepted a COM Error!!" & @CRLF & @CRLF & _
			"err.description is: " & $oErrObj.description & @CRLF & _
			"err.windescription is: " & $oErrObj.windescription & @CRLF & _
			"err.lastdllerror is: " & $oErrObj.lastdllerror & @CRLF & _
			"err.scriptline is: " & $oErrObj.scriptline & @CRLF & _
			"err.number is: " & $sHexnum & @CRLF & _
			"err.source is: " & $oErrObj.source & @CRLF & _
			"err.helpfile is: " & $oErrObj.helpfile & @CRLF & _
			"err.helpcontext is: " & $oErrObj.helpcontext _
			)
EndFunc   ;==>MyErrFunc
