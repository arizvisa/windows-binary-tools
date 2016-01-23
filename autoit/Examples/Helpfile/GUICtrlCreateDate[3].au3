#include <DateTimeConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	GUICreate("My GUI get date", 200, 200, 800, 200)
	Local $idDate = GUICtrlCreateDate("1953/04/25", 10, 10, 185, 20)

	; to select a specific default format
	Local $sStyle = "yyyy/MM/dd HH:mm:ss"
	GUICtrlSendMsg($idDate, $DTM_SETFORMATW, 0, $sStyle)

	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	While GUIGetMsg() <> $GUI_EVENT_CLOSE
	WEnd

	MsgBox($MB_SYSTEMMODAL, "Time", GUICtrlRead($idDate))
EndFunc   ;==>Example
