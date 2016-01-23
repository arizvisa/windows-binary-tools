#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <ProgressConstants.au3>

Example()

Func Example()
	GUICreate("My GUI Progressbar", 220, 100, 100, 200)
	Local $idProgressbar1 = GUICtrlCreateProgress(10, 10, 200, 20)
	GUICtrlSetColor(-1, 32250); not working with Windows XP Style
	Local $idProgressbar2 = GUICtrlCreateProgress(10, 40, 200, 20, $PBS_SMOOTH)
	Local $idButton = GUICtrlCreateButton("Start", 75, 70, 70, 20)
	GUISetState(@SW_SHOW)

	Local $iWait = 20; wait 20ms for next progressstep
	Local $iSavPos = 0; progressbar-saveposition

	Local $idMsg, $idM
	; Loop until the user exits.
	Do
		$idMsg = GUIGetMsg()
		If $idMsg = $idButton Then
			GUICtrlSetData($idButton, "Stop")
			For $i = $iSavPos To 100
				If GUICtrlRead($idProgressbar1) = 50 Then MsgBox($MB_SYSTEMMODAL, "Info", "The half is done...", 1)
				$idM = GUIGetMsg()

				If $idM = -3 Then ExitLoop

				If $idM = $idButton Then
					GUICtrlSetData($idButton, "Next")
					$iSavPos = $i;save the current bar-position to $iSavPos
					ExitLoop
				Else
					$iSavPos = 0
					GUICtrlSetData($idProgressbar1, $i)
					GUICtrlSetData($idProgressbar2, (100 - $i))
					Sleep($iWait)
				EndIf
			Next
			If $i > 100 Then
				;		$iSavPos=0
				GUICtrlSetData($idButton, "Start")
			EndIf
		EndIf
	Until $idMsg = $GUI_EVENT_CLOSE
EndFunc   ;==>Example
