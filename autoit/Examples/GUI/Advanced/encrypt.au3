; ====================================================
; ============= Encryption Tool With GUI =============
; ====================================================
; AutoIt version: 3.0.103
; Language:       English
; Author:         "Wolvereness"
; Modified:       jpm
;
; ----------------------------------------------------------------------------
; Script Start
; ----------------------------------------------------------------------------

#include <ComboConstants.au3>
#include <Crypt.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <String.au3>
; #include files for encryption and GUI constants

_Main()

Func _Main()
	; Creates window
	GUICreate('Encryption tool', 400, 400)

	; Creates main edit
	Local $idEditText = GUICtrlCreateEdit('', 5, 5, 380, 350)

	; Creates the password box with blured/centered input
	Local $idInputPass = GUICtrlCreateInput('', 5, 360, 100, 20, BitOR($ES_CENTER, $ES_PASSWORD))

	; Cretae the combo to select the crypting algorithm
	Local $idCombo = GUICtrlCreateCombo("", 110, 360, 90, 20, $CBS_DROPDOWNLIST)
	GUICtrlSetData($idCombo, "3DES|AES (128bit)|AES (192bit)|AES (256bit)|DES|RC2|RC4", "RC4")

	; Encryption/Decryption buttons
	Local $idEncryptButton = GUICtrlCreateButton('Encrypt', 210, 360, 85, 35)
	Local $idDecryptButton = GUICtrlCreateButton('Decrypt', 300, 360, 85, 35)

	; Simple text labels so you know what is what
	GUICtrlCreateLabel('Password', 5, 385)
	GUICtrlCreateLabel('Crypting Algorithm', 110, 385)

	; Shows window
	GUISetState()

	Local $iAlgorithm = $CALG_RC4
	Local $dEncrypted

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

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

			Case $idEncryptButton
				; When you press Encrypt

				; Calls the encryption. Sets the data of editbox with the encrypted string
				$dEncrypted = _Crypt_EncryptData(GUICtrlRead($idEditText), GUICtrlRead($idInputPass), $iAlgorithm) ; Encrypt the text with the new cryptographic key.
				GUICtrlSetData($idEditText, $dEncrypted)

			Case $idDecryptButton
				; When you press Decrypt

				; Calls the encryption. Sets the data of editbox with the encrypted string
				$dEncrypted = _Crypt_DecryptData(GUICtrlRead($idEditText), GUICtrlRead($idInputPass), $iAlgorithm) ; Decrypt the data using the generic password string. The return value is a binary string.
				GUICtrlSetData($idEditText, BinaryToString($dEncrypted))

		EndSwitch
	WEnd
EndFunc   ;==>_Main
