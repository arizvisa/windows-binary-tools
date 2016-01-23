#include <MsgBoxConstants.au3>

; COM Test file
;
; Testing ByRef variables on COM function calls
;
; Retrieving the Internet Explorer home page value using registry-read by WMI

Const $HKEY_CURRENT_USER = 0x80000001

Local $sComputer = @ComputerName

Local $oReg = ObjGet("winmgmts:\\" & $sComputer & "\root\default:StdRegProv")
Local $sKeyPath = "SOFTWARE\Microsoft\Internet Explorer\Main"
Local $sValueName = "Start Page"
Local $sValue = ""
Local $sReturn = $oReg.GetStringValue($HKEY_CURRENT_USER, $sKeyPath, $sValueName, $sValue)

If $sValue = "" Then
	MsgBox($MB_SYSTEMMODAL, "WMIGetStringTest", "The value of your IE start page is either Null or could not be found in the registry.")
Else
	MsgBox($MB_SYSTEMMODAL, "WMIGetStringTest", "Your Internet Explorer start page is: " & @CRLF & $sValue)
EndIf
