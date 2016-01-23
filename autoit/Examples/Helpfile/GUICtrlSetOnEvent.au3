#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Opt("GUICoordMode", 2)
	Opt("GUIResizeMode", 1)
	Opt("GUIOnEventMode", 1)

	GUICreate("Parent1")
	GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
	GUISetOnEvent($GUI_EVENT_MINIMIZE, "SpecialEvents")
	GUISetOnEvent($GUI_EVENT_RESTORE, "SpecialEvents")

	GUICtrlCreateButton("OK", 10, 30, 50)
	GUICtrlSetOnEvent(-1, "OKPressed")

	GUICtrlCreateButton("Cancel", 0, -1)
	GUICtrlSetOnEvent(-1, "CancelPressed")

	GUISetState(@SW_SHOW)

	; Just idle around
	While 1
		Sleep(10)
	WEnd
EndFunc   ;==>Example

Func OKPressed()
	MsgBox($MB_SYSTEMMODAL, "OK Pressed", "ID=" & @GUI_CtrlId & " WinHandle=" & @GUI_WinHandle & " CtrlHandle=" & @GUI_CtrlHandle)
EndFunc   ;==>OKPressed

Func CancelPressed()
	MsgBox($MB_SYSTEMMODAL, "Cancel Pressed", "ID=" & @GUI_CtrlId & " WinHandle=" & @GUI_WinHandle & " CtrlHandle=" & @GUI_CtrlHandle)
EndFunc   ;==>CancelPressed

Func SpecialEvents()
	Select
		Case @GUI_CtrlId = $GUI_EVENT_CLOSE
			MsgBox($MB_SYSTEMMODAL, "Close Pressed", "ID=" & @GUI_CtrlId & " WinHandle=" & @GUI_WinHandle)
			Exit

		Case @GUI_CtrlId = $GUI_EVENT_MINIMIZE
			MsgBox($MB_SYSTEMMODAL, "Window Minimized", "ID=" & @GUI_CtrlId & " WinHandle=" & @GUI_WinHandle)

		Case @GUI_CtrlId = $GUI_EVENT_RESTORE
			MsgBox($MB_SYSTEMMODAL, "Window Restored", "ID=" & @GUI_CtrlId & " WinHandle=" & @GUI_WinHandle)

	EndSelect
EndFunc   ;==>SpecialEvents
