#include <ComboConstants.au3>
#include <Crypt.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StringConstants.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $g_iAlgorithm = $CALG_SHA1, $g_idInputEdit = -1, $g_idOutputEdit = -1

Example()

Func Example()
	Local $hGUI = GUICreate("Realtime Hashing", 400, 320)
	$g_idInputEdit = GUICtrlCreateEdit("", 0, 0, 400, 150, $ES_WANTRETURN)
	$g_idOutputEdit = GUICtrlCreateEdit("", 0, 150, 400, 150, $ES_READONLY)
	Local $idCombo = GUICtrlCreateCombo("", 0, 300, 100, 20, $CBS_DROPDOWNLIST)
	GUICtrlSetData($idCombo, "MD2|MD4|MD5|SHA1", "SHA1")
	GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
	GUISetState(@SW_SHOW, $hGUI)

	_Crypt_Startup() ; To optimize performance start the crypt library.

	Local $dHash = 0, _
			$sRead = ""
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

			Case $idCombo ; Check when the combobox is selected and retrieve the correct algorithm.
				Switch GUICtrlRead($idCombo) ; Read the combobox selection.
					Case "MD2"
						$g_iAlgorithm = $CALG_MD2

					Case "MD4"
						$g_iAlgorithm = $CALG_MD4

					Case "MD5"
						$g_iAlgorithm = $CALG_MD5

					Case "SHA1"
						$g_iAlgorithm = $CALG_SHA1

				EndSwitch

				$sRead = GUICtrlRead($g_idInputEdit)
				If StringStripWS($sRead, $STR_STRIPALL) <> "" Then ; Check there is text available to hash.
					$dHash = _Crypt_HashData($sRead, $g_iAlgorithm) ; Create a hash of the text entered.
					GUICtrlSetData($g_idOutputEdit, $dHash) ; Set the output box with the hash data.
				EndIf
		EndSwitch
	WEnd

	GUIDelete($hGUI) ; Delete the previous GUI and all controls.
	_Crypt_Shutdown() ; Shutdown the crypt library.
EndFunc   ;==>Example

Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $lParam

	Switch _WinAPI_LoWord($wParam)
		Case $g_idInputEdit
			Switch _WinAPI_HiWord($wParam)
				Case $EN_CHANGE
					Local $dHash = _Crypt_HashData(GUICtrlRead($g_idInputEdit), $g_iAlgorithm) ; Create a hash of the text entered.
					GUICtrlSetData($g_idOutputEdit, $dHash) ; Set the output box with the hash data.
			EndSwitch
	EndSwitch
EndFunc   ;==>WM_COMMAND
