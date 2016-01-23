; using AutoIt Function

#include <GuiAVI.au3>
#include <GUIConstantsEx.au3>

_Example_Internal()

Func _Example_Internal()
	Local $idAVI, $id_Start, $id_Stop

	; Create GUI
	GUICreate("(Internal) AVI Play/Stop", 300, 200)
	$idAVI = GUICtrlCreateAvi(@SystemDir & "\shell32.dll", 160, 10, 10)
	$id_Start = GUICtrlCreateButton("start", 50, 150, 70, 22)
	$id_Stop = GUICtrlCreateButton("stop", 150, 150, 70, 22)
	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $id_Start
				; Play part of the AVI clip
				_GUICtrlAVI_Play($idAVI)
			Case $id_Stop
				; Stop AVI clip
				_GUICtrlAVI_Stop($idAVI)
		EndSwitch
	WEnd

	; Close AVI clip
	_GUICtrlAVI_Close($idAVI)

	GUIDelete()
EndFunc   ;==>_Example_Internal
