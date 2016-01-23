#include <ComboConstants.au3>
#include <Crypt.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $g_hKey = -1, $g_idInputEdit = -1, $g_idOutputEdit = -1

Example()

Func Example()
	Local $hGUI = GUICreate("Realtime Encryption", 400, 320)
	$g_idInputEdit = GUICtrlCreateEdit("", 0, 0, 400, 150, $ES_WANTRETURN)
	$g_idOutputEdit = GUICtrlCreateEdit("", 0, 150, 400, 150, $ES_READONLY)
	Local $idCombo = GUICtrlCreateCombo("", 0, 300, 100, 20, $CBS_DROPDOWNLIST)
	GUICtrlSetData($idCombo, "3DES|AES (128bit)|AES (192bit)|AES (256bit)|DES|RC2|RC4", "RC4")
	GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
	GUISetState(@SW_SHOW, $hGUI)

	_Crypt_Startup() ; To optimize performance start the crypt library.

	Local $iAlgorithm = $CALG_RC4
	$g_hKey = _Crypt_DeriveKey("CryptPassword", $iAlgorithm) ; Declare a password string and algorithm to create a cryptographic key.

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				Exit

			Case $idCombo ; Check when the combobox is selected and retrieve the correct algorithm.
				Switch GUICtrlRead($idCombo) ; Read the combobox selection.
					Case "3DES"
						$iAlgorithm = $CALG_3DES

					Case "AES (128bit)"
						$iAlgorithm = $CALG_AES_128

					Case "AES (192bit)"
						$iAlgorithm = $CALG_AES_192

					Case "AES (256bit)"
						$iAlgorithm = $CALG_AES_256

					Case "DES"
						$iAlgorithm = $CALG_DES

					Case "RC2"
						$iAlgorithm = $CALG_RC2

					Case "RC4"
						$iAlgorithm = $CALG_RC4

				EndSwitch

				_Crypt_DestroyKey($g_hKey) ; Destroy the cryptographic key.
				$g_hKey = _Crypt_DeriveKey("CryptPassword", $iAlgorithm) ; Re-declare a password string and algorithm to create a new cryptographic key.

				Local $sRead = GUICtrlRead($g_idInputEdit)
				If StringStripWS($sRead, $STR_STRIPALL) <> "" Then ; Check there is text available to encrypt.
					Local $bEncrypted = _Crypt_EncryptData($sRead, $g_hKey, $CALG_USERKEY) ; Encrypt the text with the new cryptographic key.
					GUICtrlSetData($g_idOutputEdit, $bEncrypted) ; Set the output box with the encrypted text.
				EndIf
		EndSwitch
	WEnd

	GUIDelete($hGUI) ; Delete the previous GUI and all controls.
	_Crypt_DestroyKey($g_hKey) ; Destroy the cryptographic key.
	_Crypt_Shutdown() ; Shutdown the crypt library.
EndFunc   ;==>Example

Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $lParam

	Switch _WinAPI_LoWord($wParam)
		Case $g_idInputEdit
			Switch _WinAPI_HiWord($wParam)
				Case $EN_CHANGE
					Local $bEncrypted = _Crypt_EncryptData(GUICtrlRead($g_idInputEdit), $g_hKey, $CALG_USERKEY) ; Encrypt the text with the cryptographic key.
					GUICtrlSetData($g_idOutputEdit, $bEncrypted) ; Set the output box with the encrypted text.
			EndSwitch
	EndSwitch
EndFunc   ;==>WM_COMMAND
