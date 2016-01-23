#include <FTPEx.au3>
#include <GUIConstantsEx.au3>
#include <Misc.au3>
#include <ProgressConstants.au3>

Global $g_sRemoteFile = "/pub/software/databases/rt/SRPMS/ucs-local-modperl-2.0.3-1.src.rpm"
Global $g_sLocalFile = @TempDir & "\temp.tmp"
FileDelete($g_sLocalFile)

Local $sServer = 'ftp.csx.cam.ac.uk'
Local $sUsername = ''
Local $sPass = ''

Local $hInternetSession = _FTP_Open('MyFTP Control')
; passive allows most protected FTPs to answer
Local $hFTPSession = _FTP_Connect($hInternetSession, $sServer, $sUsername, $sPass, 1)

Global $g_idProgressBarCtrl, $g_idBtn_Cancel
Example()

_FTP_Close($hInternetSession)

Func Example()
	; create GUI
	GUICreate("My GUI download Progressbar", 220, 100, 100, 200)
	GUICtrlCreateLabel($g_sRemoteFile, 10, 10)
	$g_idProgressBarCtrl = GUICtrlCreateProgress(10, 40, 200, 20, $PBS_SMOOTH)
	GUICtrlSetColor(-1, 32250); not working with Windows XP Style
	$g_idBtn_Cancel = GUICtrlCreateButton("Cancel", 75, 70, 70, 20)
	GUISetState(@SW_SHOW)

	Local $fuFunctionToCall = _UpdateGUIProgressBar
	_FTP_ProgressDownload($hFTPSession, $g_sLocalFile, $g_sRemoteFile, $fuFunctionToCall)
EndFunc   ;==>Example

Func _UpdateGUIProgressBar($iPercent)
	GUICtrlSetData($g_idProgressBarCtrl, $iPercent)
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit -1 ; _FTP_DownloadProgress Aborts with -1, so you can exit your app afterwards
		Case $g_idBtn_Cancel
			Exit -2 ; Just Cancel, without special Return value
	EndSwitch
	Return 1 ; Otherwise continue Download
EndFunc   ;==>_UpdateGUIProgressBar
