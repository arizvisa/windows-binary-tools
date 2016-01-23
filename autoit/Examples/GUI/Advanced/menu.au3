#include <Constants.au3>
#include <GUIConstantsEx.au3>

_Main()

Func _Main()
	Local $idFileMenu, $idFileItem, $idRecentFilesMenu, $idSeparator1
	Local $idExitItem, $idHelpMenu, $idAboutItem, $idOkButton, $idCancelButton
	Local $iMsg, $sFile
	#forceref $idSeparator1

	GUICreate("GUI menu", 300, 200)

	$idFileMenu = GUICtrlCreateMenu("File")
	$idFileItem = GUICtrlCreateMenuItem("Open...", $idFileMenu)
	$idRecentFilesMenu = GUICtrlCreateMenu("Recent Files", $idFileMenu)
	$idSeparator1 = GUICtrlCreateMenuItem("", $idFileMenu)
	$idExitItem = GUICtrlCreateMenuItem("Exit", $idFileMenu)
	$idHelpMenu = GUICtrlCreateMenu("?")
	$idAboutItem = GUICtrlCreateMenuItem("About", $idHelpMenu)

	$idOkButton = GUICtrlCreateButton("OK", 50, 130, 70, 20)

	$idCancelButton = GUICtrlCreateButton("Cancel", 180, 130, 70, 20)

	GUISetState()

	While 1
		$iMsg = GUIGetMsg()

		Select
			Case $iMsg = $GUI_EVENT_CLOSE Or $iMsg = $idCancelButton
				ExitLoop

			Case $iMsg = $idFileItem
				$sFile = FileOpenDialog("Choose file...", @TempDir, "All (*.*)")
				If @error <> 1 Then GUICtrlCreateMenuItem($sFile, $idRecentFilesMenu)

			Case $iMsg = $idExitItem
				ExitLoop

			Case $iMsg = $idOkButton
				MsgBox($MB_SYSTEMMODAL, "Click", "You clicked OK!")

			Case $iMsg = $idAboutItem
				MsgBox($MB_SYSTEMMODAL, "About", "GUI Menu Test")
		EndSelect
	WEnd

	GUIDelete()

	Exit
EndFunc   ;==>_Main
