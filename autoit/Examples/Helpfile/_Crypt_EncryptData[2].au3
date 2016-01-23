#include <Crypt.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Encrypt text using a generic password.
	Local $sEncrypted = StringEncrypt(True, 'Encrypt this data.', 'securepassword')

	; Display the encrypted text.
	MsgBox($MB_SYSTEMMODAL, '', $sEncrypted)

	; Decrypt the encrypted text using the generic password.
	Local $sDecrypted = StringEncrypt(False, $sEncrypted, 'securepassword')

	; Display the decrypted text.
	MsgBox($MB_SYSTEMMODAL, '', $sDecrypted)
EndFunc   ;==>Example

Func StringEncrypt($bEncrypt, $sData, $sPassword)
	_Crypt_Startup() ; Start the Crypt library.
	Local $sReturn = ''
	If $bEncrypt Then ; If the flag is set to True then encrypt, otherwise decrypt.
		$sReturn = _Crypt_EncryptData($sData, $sPassword, $CALG_RC4)
	Else
		$sReturn = BinaryToString(_Crypt_DecryptData($sData, $sPassword, $CALG_RC4))
	EndIf
	_Crypt_Shutdown() ; Shutdown the Crypt library.
	Return $sReturn
EndFunc   ;==>StringEncrypt
