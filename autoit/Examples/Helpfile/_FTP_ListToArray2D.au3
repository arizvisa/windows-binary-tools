#include <FTPEx.au3>

Local $sServer = 'ftp.csx.cam.ac.uk'
Local $sUsername = ''
Local $sPass = ''

Local $hOpen = _FTP_Open('MyFTP Control')
Local $hConn = _FTP_Connect($hOpen, $sServer, $sUsername, $sPass)

Local $aFile = _FTP_ListToArray2D($hConn, 0)
ConsoleWrite('$sFileName = ' & $aFile[0][0] & '  -> Error code: ' & @error & @CRLF)
ConsoleWrite('$sFileName = ' & $aFile[1][0] & ' size = ' & $aFile[1][1] & @error & @CRLF)
ConsoleWrite('$sFileName = ' & $aFile[2][0] & ' size = ' & $aFile[2][1] & @CRLF)

Local $iFtpc = _FTP_Close($hConn)
Local $iFtpo = _FTP_Close($hOpen)
