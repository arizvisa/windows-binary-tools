#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <StaticConstants.au3>

Example()

Func Example()
	Local $sDefaultstatus = "Ready"

	GUICreate("My GUI menu", 300, 200)

	Local $idFilemenu = GUICtrlCreateMenu("&File")
	Local $idFileitem = GUICtrlCreateMenuItem("Open", $idFilemenu)
	GUICtrlSetState(-1, $GUI_DEFBUTTON)
	Local $idHelpmenu = GUICtrlCreateMenu("?")
	GUICtrlCreateMenuItem("Save", $idFilemenu)
	GUICtrlSetState(-1, $GUI_DISABLE)
	Local $idInfoitem = GUICtrlCreateMenuItem("Info", $idHelpmenu)
	Local $idExititem = GUICtrlCreateMenuItem("Exit", $idFilemenu)
	Local $idRecentfilesmenu = GUICtrlCreateMenu("Recent Files", $idFilemenu, 1)

	GUICtrlCreateMenuItem("", $idFilemenu, 2) ; create a separator line

	Local $idViewmenu = GUICtrlCreateMenu("View", -1, 1) ; is created before "?" menu
	Local $idViewstatusitem = GUICtrlCreateMenuItem("Statusbar", $idViewmenu)
	GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlCreateButton("OK", 50, 130, 70, 20)
	GUICtrlSetState(-1, $GUI_FOCUS)
	Local $idCancelbutton = GUICtrlCreateButton("Cancel", 180, 130, 70, 20)

	Local $idStatuslabel = GUICtrlCreateLabel($sDefaultstatus, 0, 165, 300, 16, BitOR($SS_SIMPLE, $SS_SUNKEN))

	GUISetState(@SW_SHOW)

	Local $sFile
	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $idFileitem
				$sFile = FileOpenDialog("Choose file...", @TempDir, "All (*.*)")
				If @error <> 1 Then GUICtrlCreateMenuItem($sFile, $idRecentfilesmenu)
			Case $idViewstatusitem
				If BitAND(GUICtrlRead($idViewstatusitem), $GUI_CHECKED) = $GUI_CHECKED Then
					GUICtrlSetState($idViewstatusitem, $GUI_UNCHECKED)
					GUICtrlSetState($idStatuslabel, $GUI_HIDE)
				Else
					GUICtrlSetState($idViewstatusitem, $GUI_CHECKED)
					GUICtrlSetState($idStatuslabel, $GUI_SHOW)
				EndIf
			Case $GUI_EVENT_CLOSE, $idCancelbutton, $idExititem
				ExitLoop
			Case $idInfoitem
				MsgBox($MB_SYSTEMMODAL, "Info", "Only a test...")
		EndSwitch
	WEnd
	GUIDelete()
EndFunc   ;==>Example
