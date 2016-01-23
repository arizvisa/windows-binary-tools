#include <FTPEx.au3>
#include <GUIConstantsEx.au3>
#include <Misc.au3>
#include <ProgressConstants.au3>

; This example NEED TO BE ADAPTED to valid $g_sRemoteFile/$sServer/$sUsername/$sPass

Global $g_sRemoteFile = "/pub/software/databases/rt/SRPMS/ucs-local-modperl-2.0.3-1.src.rpm"
Global $g_sLocalFile = @TempDir & "\temp.tmp"

Local $sServer = 'ftp.csx.cam.ac.uk'
Local $sUsername = ''
Local $sPass = ''

Local $hInternetSession = _FTP_Open('MyFTP Control')
; passive allows most protected FTPs to answer
Local $hFTPSession = _FTP_Connect($hInternetSession, $sServer, $sUsername, $sPass, 1)

Example()

_FTP_Close($hInternetSession)

Func Example()
	Local $fuFunctionToCall = _UpdateProgress
	ProgressOn("Upload Progress", $g_sRemoteFile)
	_FTP_ProgressUpload($hFTPSession, $g_sLocalFile, $g_sRemoteFile, $fuFunctionToCall)
	ProgressOff()
EndFunc   ;==>Example

Func _UpdateProgress($iPercent)
	ProgressSet($iPercent, $iPercent & "%")
	If _IsPressed("77") Then Return 0 ; Abort on F8
	Return 1 ; Continue upload
EndFunc   ;==>_UpdateProgress
