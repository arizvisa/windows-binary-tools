#include <APIMiscConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIMisc.au3>

Local Const $sWav = @ScriptDir & '\Extras\Airplane.wav'

; Read Airplane.wav to memory
Local $dWav = FileRead($sWav)
If @error Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Unable to read "' & $sWav & '"')
	Exit
EndIf
Local $tWav = DllStructCreate('byte[' & BinaryLen($dWav) & ']')
DllStructSetData($tWav, 1, $dWav)
Local $pWav = DllStructGetPtr($tWav)

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 200, 200)
Local $idButton = GUICtrlCreateButton('Play', 70, 70, 60, 60)
GUISetState(@SW_SHOW)

Local $bPlay = False
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $idButton
			$bPlay = Not $bPlay
			If $bPlay Then
				_WinAPI_PlaySound($pWav, BitOR($SND_ASYNC, $SND_LOOP, $SND_MEMORY))
;~ 				_WinAPI_PlaySound($sWav, BitOR($SND_ASYNC, $SND_LOOP))
				GUICtrlSetData($idButton, 'Stop')
			Else
				_WinAPI_PlaySound('')
				GUICtrlSetData($idButton, 'Play')
			EndIf
	EndSwitch
WEnd
