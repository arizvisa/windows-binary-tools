#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <StaticConstants.au3>

Example()

Func Example()
	GUICreate("My GUI menu", 300, 200)

	Local $sStatus = "Ready"

	Local $idFileMenu = GUICtrlCreateMenu("&File")
	Local $idFileItem = GUICtrlCreateMenuItem("Open", $idFileMenu)
	GUICtrlSetState(-1, $GUI_DEFBUTTON)
	Local $idHelpMenu = GUICtrlCreateMenu("?")
	GUICtrlCreateMenuItem("Save", $idFileMenu)
	GUICtrlSetState(-1, $GUI_DISABLE)
	Local $idInfoItem = GUICtrlCreateMenuItem("Info", $idHelpMenu)
	Local $idExit = GUICtrlCreateMenuItem("Exit", $idFileMenu)
	Local $idRecentFilesMenu = GUICtrlCreateMenu("Recent Files", $idFileMenu, 1)

	GUICtrlCreateMenuItem("", $idFileMenu, 2) ; Create a separator line

	Local $idViewMenu = GUICtrlCreateMenu("View", -1, 1) ; Is created before "?" menu
	Local $idViewStatusItem = GUICtrlCreateMenuItem("Statusbar", $idViewMenu)
	GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlCreateButton("OK", 50, 130, 70, 20)
	GUICtrlSetState(-1, $GUI_FOCUS)
	Local $idCancel = GUICtrlCreateButton("Cancel", 180, 130, 70, 20)

	Local $idStatusLabel = GUICtrlCreateLabel($sStatus, 0, 165, 300, 16, BitOR($SS_SIMPLE, $SS_SUNKEN))

	GUISetState(@SW_SHOW)

	Local $sFilePath
	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE, $idCancel, $idExit
				Exit

			Case $idInfoItem
				MsgBox($MB_SYSTEMMODAL, "Info", "Only a test...")

			Case $idFileItem
				$sFilePath = FileOpenDialog("Choose a file...", @TempDir, "All (*.*)")
				If @error Then
					ContinueLoop
				EndIf
				GUICtrlCreateMenuItem($sFilePath, $idRecentFilesMenu)

			Case $idViewStatusItem
				If BitAND(GUICtrlRead($idViewStatusItem), $GUI_CHECKED) = $GUI_CHECKED Then
					GUICtrlSetState($idViewStatusItem, $GUI_UNCHECKED)
					GUICtrlSetState($idStatusLabel, $GUI_HIDE)
				Else
					GUICtrlSetState($idViewStatusItem, $GUI_CHECKED)
					GUICtrlSetState($idStatusLabel, $GUI_SHOW)
				EndIf
		EndSwitch
	WEnd
EndFunc   ;==>Example
