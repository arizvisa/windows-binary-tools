#include <GUIConstantsEx.au3>

Global $g_idUserDummy, $g_iState = 0

Example()

Func Example()
	Opt("GUIOnEventMode", 1) ; Set the option to use GUIOnEventMode.

	GUICreate("GUISendToDummy", 220, 200, 100, 200)
	GUISetBkColor(0x00E0FFFF) ; Change the background color of the GUI.
	GUISetOnEvent($GUI_EVENT_CLOSE, "OnExit") ; Set an event to call the 'OnExit' function.

	$g_idUserDummy = GUICtrlCreateDummy()
	GUICtrlSetOnEvent(-1, "OnDummy") ; Set an event to call the 'OnExit' function when this control is selected.

	GUICtrlCreateButton("Click", 70, 170, 85, 25)
	GUICtrlSetOnEvent(-1, "OnClick") ; Set an event to call the 'OnClick' function when this control is selected.

	GUICtrlSendToDummy($g_idUserDummy, 1) ; Set state to be checked Onclick

	; Display the GUI.
	GUISetState(@SW_SHOW)
	; Loop until the user exits.
	While 1
		Sleep(100)
	WEnd
EndFunc   ;==>Example

Func OnClick()
	Return GUICtrlSendToDummy($g_idUserDummy) ; Send a message to the dummy control that the close button was selected, which will then proceed to call the function 'OnExit'.
EndFunc   ;==>OnClick

Func OnDummy()
	If GUICtrlRead($g_idUserDummy) Then
		GUISetBkColor(0x000000FF) ; Change the background color of the GUI on dummy state
	Else
		Exit
	EndIf
EndFunc   ;==>OnDummy

Func OnExit()
	Exit ; Exit the script.
EndFunc   ;==>OnExit
