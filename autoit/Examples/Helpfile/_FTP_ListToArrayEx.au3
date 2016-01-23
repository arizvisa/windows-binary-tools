#include <Array.au3>
#include <FTPEx.au3>
#include <MsgBoxConstants.au3>

Local $sServer = 'ftp.csx.cam.ac.uk1'
Local $sUsername = ''
Local $sPass = ''

Local $hOpen = _FTP_Open('MyFTP Control', 0)
If Not @error Then
	; passive allows most protected FTPs to answer
	Local $hConn = _FTP_Connect($hOpen, $sServer, $sUsername, $sPass)
	If Not @error Then
		Local $aFile = _FTP_ListToArrayEx($hConn, 0)
		If Not @error Then
			_ArrayDisplay($aFile)
		Else
			MsgBox($MB_SYSTEMMODAL, "Error", '_FTP_ListToArrayEx($Conn, 0)' & @CRLF & _
					'@error = ' & @error & ' @extended = ' & @extended)
		EndIf
		Local $iFtpc = _FTP_Close($hConn)
	Else
		MsgBox($MB_SYSTEMMODAL, "Error", '_FTP_Connect($Open, ' & $sServer & ', ' & $sUsername & ', ' & $sPass & ')' & @CRLF & _
				'@error = ' & @error & ' @extended = ' & @extended)
	EndIf

	Local $iFtpo = _FTP_Close($hOpen)
Else
	MsgBox($MB_SYSTEMMODAL, "Error", "_FTP_Open('MyFTP Control')" & @CRLF & _
			'@error = ' & @error & ' @extended = ' & @extended)
EndIf
