#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

GUICreate("GUI with simple context menu", 300, 200)

Local $idTrackMenu = GUICtrlCreateContextMenu()
Local $idAboutItem = GUICtrlCreateMenuItem("About", $idTrackMenu)
; next one creates a menu separator (line)
GUICtrlCreateMenuItem("", $idTrackMenu)
Local $idExitItem = GUICtrlCreateMenuItem("Exit", $idTrackMenu)

GUISetState()

While 1
	Local $iMsg = GUIGetMsg()
	If $iMsg = $idExitItem Or $iMsg = $GUI_EVENT_CLOSE Or $iMsg = -1 Then ExitLoop
	If $iMsg = $idAboutItem Then MsgBox($MB_SYSTEMMODAL, "About", "A simple example with a context menu!")
WEnd
