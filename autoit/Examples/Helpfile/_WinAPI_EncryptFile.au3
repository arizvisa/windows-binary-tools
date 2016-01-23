#include <APIFilesConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

Local $sFile = FileOpenDialog('Select File', @ScriptDir, 'All Files (*.*)', 1 + 2)
If @error Then Exit

Switch _WinAPI_FileEncryptionStatus($sFile)
	Case $FILE_ENCRYPTABLE
		If _WinAPI_EncryptFile($sFile) Then
			MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), 'Encryption File', 'The file encrypted is successfully.')
		Else
			MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Encryption File', 'Unable to encrypt file.')
		EndIf
	Case $FILE_IS_ENCRYPTED
		If MsgBox(BitOR($MB_YESNO, $MB_ICONQUESTION, $MB_SYSTEMMODAL), 'Encryption File', 'The file is already encrypted.' & @CRLF & @CRLF & 'Decrypt?') = 6 Then
			If _WinAPI_DecryptFile($sFile) Then
				MsgBox(BitOR($MB_ICONINFORMATION, $MB_SYSTEMMODAL), 'Encryption File', 'The file decrypted is successfully.')
			Else
				MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Encryption File', 'Unable to decrypt file.')
			EndIf
		EndIf
	Case Else
		MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Encryption File', 'Unable to perform operation.')
EndSwitch
