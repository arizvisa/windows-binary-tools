#include <GuiAVI.au3>
#include <GUIConstantsEx.au3>

_Example_External()

Func _Example_External()
	Local $hGUI, $hAVI, $id_Start, $id_Stop, $id_Show

	; Create GUI
	$hGUI = GUICreate("(External) AVI Play", 350, 200)
	$hAVI = _GUICtrlAVI_Create($hGUI, @SystemDir & "\Shell32.dll", 160, 10, 10)
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
				_GUICtrlAVI_Play($hAVI)
			Case $id_Stop
				; Stop AVI clip
				_GUICtrlAVI_Stop($hAVI)
			Case $id_Show
				If GUICtrlRead($id_Show) = "hide" Then
					_GUICtrlAVI_Show($hAVI, @SW_HIDE)
					GUICtrlSetData($id_Show, "show")
				Else
					_GUICtrlAVI_Show($hAVI, @SW_SHOW)
					GUICtrlSetData($id_Show, "hide")
				EndIf
		EndSwitch
	WEnd

	; Close AVI clip
	_GUICtrlAVI_Close($hAVI)

	GUIDelete()
EndFunc   ;==>_Example_External
