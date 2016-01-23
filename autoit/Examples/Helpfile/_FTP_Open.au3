#include <FTPEx.au3>

Local $hOpen = _FTP_Open('MyFTP Control')
; ...
Local $iFtpc = _FTP_Close($hOpen)
