#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGui = GUICreate("My GUI", 170, 40)

	Local $idOptionsBtn = GUICtrlCreateButton("&Options", 10, 10, 70, 20, $BS_FLAT)

	; At first create a dummy control for the options and a contextmenu for it
	Local $idOptionsDummy = GUICtrlCreateDummy()
	Local $idOptionsContext = GUICtrlCreateContextMenu($idOptionsDummy)
	GUICtrlCreateMenuItem("Common", $idOptionsContext)
	GUICtrlCreateMenuItem("File", $idOptionsContext)
	GUICtrlCreateMenuItem("", $idOptionsContext)
	Local $idOptionsExit = GUICtrlCreateMenuItem("Exit", $idOptionsContext)

	Local $idHelpBtn = GUICtrlCreateButton("&Help", 90, 10, 70, 20, $BS_FLAT)

	; Create a dummy control and a contextmenu for the help too
	Local $idHelpDummy = GUICtrlCreateDummy()
	Local $idHelpContext = GUICtrlCreateContextMenu($idHelpDummy)
	GUICtrlCreateMenuItem("Website", $idHelpContext)
	GUICtrlCreateMenuItem("", $idHelpContext)
	Local $idHelpAbout = GUICtrlCreateMenuItem("About...", $idHelpContext)

	GUISetState(@SW_SHOW)

	Local $idMsg

	; Loop until the user exits.
	While 1
		$idMsg = GUIGetMsg()

		Switch $idMsg
			Case $idOptionsExit, $GUI_EVENT_CLOSE
				ExitLoop

			Case $idOptionsBtn
				ShowMenu($hGui, $idMsg, $idOptionsContext)

			Case $idHelpBtn
				ShowMenu($hGui, $idMsg, $idHelpContext)

			Case $idHelpAbout
				MsgBox($MB_SYSTEMMODAL, "About...", "GUICtrlGetHandle-Sample")
		EndSwitch
	WEnd
	GUIDelete()
EndFunc   ;==>Example

; Show a menu in a given GUI window which belongs to a given GUI ctrl
Func ShowMenu($hWnd, $idCtrl, $idContext)
	Local $aPos, $x, $y
	Local $hMenu = GUICtrlGetHandle($idContext)

	$aPos = ControlGetPos($hWnd, "", $idCtrl)

	$x = $aPos[0]
	$y = $aPos[1] + $aPos[3]

	ClientToScreen($hWnd, $x, $y)
	TrackPopupMenu($hWnd, $hMenu, $x, $y)
EndFunc   ;==>ShowMenu

; Convert the client (GUI) coordinates to screen (desktop) coordinates
Func ClientToScreen($hWnd, ByRef $x, ByRef $y)
	Local $tPoint = DllStructCreate("int;int")

	DllStructSetData($tPoint, 1, $x)
	DllStructSetData($tPoint, 2, $y)

	DllCall("user32.dll", "int", "ClientToScreen", "hwnd", $hWnd, "struct*", $tPoint)

	$x = DllStructGetData($tPoint, 1)
	$y = DllStructGetData($tPoint, 2)
	; release Struct not really needed as it is a local
	$tPoint = 0
EndFunc   ;==>ClientToScreen

; Show at the given coordinates (x, y) the popup menu (hMenu) which belongs to a given GUI window (hWnd)
Func TrackPopupMenu($hWnd, $hMenu, $x, $y)
	DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $x, "int", $y, "hwnd", $hWnd, "ptr", 0)
EndFunc   ;==>TrackPopupMenu
