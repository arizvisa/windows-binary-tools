#include <GUIConstantsEx.au3>
#include <Misc.au3>

Example()

Func Example()
	; Create a GUI with various controls.
	Local $hGUI = GUICreate("Mouse Trap Example")

	; Display the GUI.
	GUISetState(@SW_SHOW, $hGUI)

	; Hold the window's position.
	Local $aCoords = 0

	; Loop until the user exits.
	While 1
		$aCoords = WinGetPos($hGUI)
		If Not @error Then
			; If no error occurs, then trap the mouse cursor between the window client.
			_MouseTrap($aCoords[0], $aCoords[1], $aCoords[0] + $aCoords[2], $aCoords[1] + $aCoords[3])
		EndIf
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd

	; Release the mouse cursor
	_MouseTrap()
EndFunc   ;==>Example
