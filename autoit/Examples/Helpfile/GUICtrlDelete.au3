#include <GUIConstantsEx.au3>

Example()

Func Example()
	GUICreate("My GUI delete control", 200, 200, 800, 200)
	Local $idDate = GUICtrlCreateDate("1953/04/25", 10, 10, 185, 20)
	Local $idDel = GUICtrlCreateButton("Delete control", 50, 50, 70, 20)
	GUISetState(@SW_SHOW)

	Local $idMsg
	; Loop until the user exits.
	Do
		$idMsg = GUIGetMsg()
		If $idMsg = $idDel Then
			GUICtrlDelete($idDate)
			GUICtrlDelete($idDel)
		EndIf
	Until $idMsg = $GUI_EVENT_CLOSE
EndFunc   ;==>Example
