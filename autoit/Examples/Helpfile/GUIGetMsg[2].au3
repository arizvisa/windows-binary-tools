#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Create a GUI.
	Local $hGUI1 = GUICreate("Example GUI1")
	; Create a button.
	Local $idButton1 = GUICtrlCreateButton("Button1", 10, 10, 80, 22)
	; Display the GUI
	GUISetState(@SW_SHOW, $hGUI1)

	; Create a GUI.
	Local $hGUI2 = GUICreate("Example GUI2", 300, 300)
	; Create a button.
	Local $idButton2 = GUICtrlCreateButton("Button2", 10, 10, 80, 22)
	; Display the GUI
	GUISetState(@SW_SHOW, $hGUI2)

	; Initialize a Local variable.
	Local $aMsg = 0

	While 1
		; Assign to $aMsg the advanced GUI messages.
		$aMsg = GUIGetMsg($GUI_EVENT_ARRAY)

		; Switch from GUIs
		Switch $aMsg[1]
			Case $hGUI1
				; The event comes from the GUI1

				; Switch from event ID
				Switch $aMsg[0]
					Case $GUI_EVENT_CLOSE
						ExitLoop
					Case $idButton1
						MsgBox($MB_SYSTEMMODAL, "", "Button1 clicked.")
				EndSwitch
			Case $hGUI2
				; The event comes from the GUI2

				; Switch from event ID
				Switch $aMsg[0]
					Case $GUI_EVENT_CLOSE
						GUIDelete($hGUI2)
					Case $idButton2
						MsgBox($MB_SYSTEMMODAL, "", "Button2 clicked.")
				EndSwitch
		EndSwitch
	WEnd

	; Delete the previous GUIs and all controls.
	GUIDelete($hGUI1)
EndFunc   ;==>Example
