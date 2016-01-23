#include <MsgBoxConstants.au3>

; COM Test file
;
; Test usage of creating objects on a remote computer
;
; Notes:
;
; - The remote Object must have DCOM (Distributed COM) functionality.
; - The remote computer must have 'Remote Registry Service' and 'File and Printersharing' turned on!
;
; To check for any DCOM-Enabled Objects, use DCOMCNFG.EXE (=Component Services MMC) on the remote computer.

Local $sRemoteComputer = "REMOTE" ; Change this to your remote computer name
Local $sRemoteUsername = "REMOTE\Administrator" ; Change this to your username on the remote computer
Local $sRemotePassword = "123456" ; Change this to your password on the remote computer

; First install our own Error Handler
Global $g_nCOMError = 0, $g_oErrObj = ObjEvent("AutoIt.Error", "MyErrFunc")

; Open MediaPlayer on a remote computer
Local $oRemoteMedia = ObjCreate("MediaPlayer.MediaPlayer.1", $sRemoteComputer, $sRemoteUsername, $sRemotePassword)

If @error Then
	MsgBox($MB_SYSTEMMODAL, "Remote ObjCreate Test", "Failed to open remote Object. Error code: " & Hex(@error, 8))
	Exit
EndIf

MsgBox($MB_SYSTEMMODAL, "Remote Test", "ObjCreate() of a remote object successfull !")

Local $iEnabled = $oRemoteMedia.IsSoundCardEnabled

If Not @error Then
	MsgBox($MB_SYSTEMMODAL, "Remote Test", "Invoking a method on a remote Object successfull!" & @CRLF & _
			"Result of 'IsSoundCardEnabled?':  " & $iEnabled)
	If $iEnabled = -1 Then
		$oRemoteMedia.Open("c:\windows\media\Windows XP Startup.wav")
		If Not @error Then MsgBox($MB_SYSTEMMODAL, "Remote Test", "Playing sound on a remote computer successful !")
	EndIf
Else
	MsgBox($MB_SYSTEMMODAL, "Remote Test", "Invoking a method on a remote Object Failed !")
EndIf

Exit

; ------------------------
; My custom error function

Func MyErrFunc()
	Local $sHexnum = Hex($g_oErrObj.number, 8)

	MsgBox($MB_SYSTEMMODAL, "", "We intercepted a COM Error!!" & @CRLF & @CRLF & _
			"err.description is: " & $g_oErrObj.description & @CRLF & _
			"err.windescription is: " & $g_oErrObj.windescription & @CRLF & _
			"err.lastdllerror is: " & $g_oErrObj.lastdllerror & @CRLF & _
			"err.scriptline is: " & $g_oErrObj.scriptline & @CRLF & _
			"err.number is: " & $sHexnum & @CRLF & _
			"err.source is: " & $g_oErrObj.source & @CRLF & _
			"err.helpfile is: " & $g_oErrObj.helpfile & @CRLF & _
			"err.helpcontext is: " & $g_oErrObj.helpcontext _
			)

	$g_nCOMError = $g_oErrObj.number
EndFunc   ;==>MyErrFunc
