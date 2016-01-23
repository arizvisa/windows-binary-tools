#include <APIDlgConstants.au3>
#include <Crypt.au3>
#include <MsgBoxConstants.au3>
#include <WinAPI.au3>
#include <WinAPIDlg.au3>

Local $hBitmap = _WinAPI_LoadImage(0, @ScriptDir & '\Extras\Authentication.bmp', $IMAGE_BITMAP, 0, 0, $LR_LOADFROMFILE)
Local $aData[3] = ['', '', 0]

While 1
	$aData = _WinAPI_ShellUserAuthenticationDlg('Authentication', 'To continue, type a login and password, and then click OK.', $aData[0], $aData[1], 'MyScript', BitOR($CREDUI_FLAGS_ALWAYS_SHOW_UI, $CREDUI_FLAGS_EXPECT_CONFIRMATION, $CREDUI_FLAGS_GENERIC_CREDENTIALS, $CREDUI_FLAGS_SHOW_SAVE_CHECK_BOX), 0, $aData[2], $hBitmap)
	If @error Then Exit

	If (StringCompare($aData[0], 'AutoIt')) Or (StringCompare($aData[1], StringEncrypt(False, 'DC7E430A1C88', '123'))) Then
		If $aData[2] Then
			_WinAPI_ConfirmCredentials('MyScript', 0)
		EndIf
		MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'You have typed an incorrect login or password, it should be "AutoIt" and "123".')
	Else
		If $aData[2] Then
			_WinAPI_ConfirmCredentials('MyScript', 1)
		EndIf
		ExitLoop
	EndIf
WEnd

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
