#include <FTPEx.au3>

Local $sServer = 'ftp.csx.cam.ac.uk'
Local $sUsername = ''
Local $sPass = ''

Local $hOpen = _FTP_Open('MyFTP Control')
Local $hConn = _FTP_Connect($hOpen, $sServer, $sUsername, $sPass)

Local $aFile = _FTP_ListToArray($hConn, 2)
ConsoleWrite('$NbFound = ' & $aFile[0] & '  -> Error code: ' & @error & @CRLF)
ConsoleWrite('$sFileName = ' & $aFile[1] & @CRLF)

Local $iFtpc = _FTP_Close($hConn)
Local $iFtpo = _FTP_Close($hOpen)
