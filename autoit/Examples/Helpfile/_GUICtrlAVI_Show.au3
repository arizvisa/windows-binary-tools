; using AutoIt Function

#include <GuiAVI.au3>
#include <GUIConstantsEx.au3>

_Example_Internal()

Func _Example_Internal()
	Local $id_AVI, $id_Start, $id_Stop, $id_Show

	; Create GUI
	GUICreate("(Internal) AVI Play", 350, 200)
	$id_AVI = GUICtrlCreateAvi(@SystemDir & "\shell32.dll", 160, 10, 10)
	$id_Start = GUICtrlCreateButton("start", 25, 150, 70, 22)
	$id_Stop = GUICtrlCreateButton("stop", 125, 150, 70, 22)
	$id_Show = GUICtrlCreateButton("hide", 225, 150, 70, 22)
	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $id_Start
				; Play part of the AVI clip
				_GUICtrlAVI_Play($id_AVI)
			Case $id_Stop
				; Stop AVI clip
				_GUICtrlAVI_Stop($id_AVI)
			Case $id_Show
				If GUICtrlRead($id_Show) = "hide" Then
					_GUICtrlAVI_Show($id_AVI, @SW_HIDE)
					GUICtrlSetData($id_Show, "show")
				Else
					_GUICtrlAVI_Show($id_AVI, @SW_SHOW)
					GUICtrlSetData($id_Show, "hide")
				EndIf
		EndSwitch
	WEnd

	; Close AVI clip
	_GUICtrlAVI_Close($id_AVI)

	GUIDelete()
EndFunc   ;==>_Example_Internal
