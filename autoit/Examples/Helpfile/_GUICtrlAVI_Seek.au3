; usinf AutoIt Function

#include <GuiAVI.au3>
#include <GUIConstantsEx.au3>

_Example_Internal()

Func _Example_Internal()
	; Create GUI
	GUICreate("(Internal) AVI Seek", 300, 100)
	Local $idAVI = GUICtrlCreateAvi(@SystemDir & "\shell32.dll", 160, 10, 10)
	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	Do
		Sleep(100)
		; Seek to a random frame in the AVI Clip
		_GUICtrlAVI_Seek($idAVI, Random(1, 30, 1))
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Close AVI clip
	_GUICtrlAVI_Close($idAVI)

	GUIDelete()
EndFunc   ;==>_Example_Internal
