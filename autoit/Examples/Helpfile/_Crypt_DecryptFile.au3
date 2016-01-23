#include <ComboConstants.au3>
#include <Crypt.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>

Example()

Func Example()
	Local $iAlgorithm = $CALG_RC4

	Local $hGUI = GUICreate("File Decrypter", 425, 100)
	Local $idSourceInput = GUICtrlCreateInput("", 5, 5, 200, 20)
	Local $idSourceBrowse = GUICtrlCreateButton("...", 210, 5, 35, 20)

	Local $idDestinationInput = GUICtrlCreateInput("", 5, 30, 200, 20)
	Local $idDestinationBrowse = GUICtrlCreateButton("...", 210, 30, 35, 20)

	GUICtrlCreateLabel("Password:", 5, 60, 200, 20)
	Local $idPasswordInput = GUICtrlCreateInput("", 5, 75, 200, 20)

	Local $idCombo = GUICtrlCreateCombo("", 210, 75, 100, 20, $CBS_DROPDOWNLIST)
	GUICtrlSetData($idCombo, "3DES|AES (128bit)|AES (192bit)|AES (256bit)|DES|RC2|RC4", "RC4")
	Local $idDecrypt = GUICtrlCreateButton("Decrypt", 355, 70, 65, 25)
	GUISetState(@SW_SHOW, $hGUI)

	Local $sDestinationRead = "", $sFilePath = "", $sPasswordRead = "", $sSourceRead = ""
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

			Case $idSourceBrowse
				$sFilePath = FileOpenDialog("Select a file to decrypt.", "", "All files (*.*)") ; Select a file to decrypt.
				If @error Then
					ContinueLoop
				EndIf
				GUICtrlSetData($idSourceInput, $sFilePath) ; Set the inputbox with the filepath.

			Case $idDestinationBrowse
				$sFilePath = FileSaveDialog("Save the file as ...", "", "All files (*.*)") ; Select a file to save the decrypted data to.
				If @error Then
					ContinueLoop
				EndIf
				GUICtrlSetData($idDestinationInput, $sFilePath) ; Set the inputbox with the filepath.

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

			Case $idDecrypt
				$sSourceRead = GUICtrlRead($idSourceInput) ; Read the source filepath input.
				$sDestinationRead = GUICtrlRead($idDestinationInput) ; Read the destination filepath input.
				$sPasswordRead = GUICtrlRead($idPasswordInput) ; Read the password input.
				If StringStripWS($sSourceRead, $STR_STRIPALL) <> "" And StringStripWS($sDestinationRead, $STR_STRIPALL) <> "" And StringStripWS($sPasswordRead, $STR_STRIPALL) <> "" And FileExists($sSourceRead) Then ; Check there is a file available to decrypt and a password has been set.
					If _Crypt_DecryptFile($sSourceRead, $sDestinationRead, $sPasswordRead, $iAlgorithm) Then ; Decrypt the file.
						MsgBox($MB_SYSTEMMODAL, "Success", "Operation succeeded.")
					Else
						Switch @error
							Case 1
								MsgBox($MB_SYSTEMMODAL, "Error", "Failed to create the key.")
							Case 2
								MsgBox($MB_SYSTEMMODAL, "Error", "Couldn't open the source file.")
							Case 3
								MsgBox($MB_SYSTEMMODAL, "Error", "Couldn't open the destination file.")
							Case 4 Or 5
								MsgBox($MB_SYSTEMMODAL, "Error", "Decryption error.")
						EndSwitch
					EndIf
				Else
					MsgBox($MB_SYSTEMMODAL, "Error", "Please ensure the relevant information has been entered correctly.")
				EndIf
		EndSwitch
	WEnd

	GUIDelete($hGUI) ; Delete the previous GUI and all controls.
EndFunc   ;==>Example
