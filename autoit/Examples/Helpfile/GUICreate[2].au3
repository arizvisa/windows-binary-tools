#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $sFilePath = "..\GUI\logo4.gif"

	; Create a GUI with various controls.
	Local $hGUI = GUICreate("Example", 400, 100)
	GUICtrlCreatePic("..\GUI\msoobe.jpg", 0, 0, 400, 100)

	; Display the GUI.
	GUISetState(@SW_SHOW, $hGUI)

	Local $hChild = GUICreate("", 169, 68, 20, 20, $WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $hGUI)

	; Create a picture control with a transparent image.
	GUICtrlCreatePic($sFilePath, 0, 0, 169, 68)

	; Display the child GUI.
	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd

	; Delete the previous GUIs and all controls.
	GUIDelete($hGUI)
	GUIDelete($hChild)
EndFunc   ;==>Example
