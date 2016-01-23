#include <FTPEx.au3>
#include <MsgBoxConstants.au3>

Local $sServer = 'ftp.csx.cam.ac.uk' ; UNIVERSITY OF CAMBRIDGE ANONYMOUS FTP SERVER
Local $sUsername = ''
Local $sPass = ''

Local $hOpen = _FTP_Open('MyFTP Control')
Local $hConn = _FTP_Connect($hOpen, $sServer, $sUsername, $sPass)
If @error Then
	MsgBox($MB_SYSTEMMODAL, '_FTP_Connect', 'ERROR=' & @error)
Else
	; do something ...
EndIf
Local $iFtpc = _FTP_Close($hConn)
Local $iFtpo = _FTP_Close($hOpen)
