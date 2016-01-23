#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Opt("GUICoordMode", 2)
	GUICreate("My InputBox", 190, 114, -1, -1, $WS_SIZEBOX + $WS_SYSMENU) ; start the definition

	GUISetFont(8, -1, "Arial")

	GUICtrlCreateLabel("Prompt", 8, 7) ; add prompt info
	GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP)

	Local $idEdit = GUICtrlCreateInput("Default", -1, 3, 175, 20, $ES_PASSWORD) ; add the input area
	GUICtrlSetState($idEdit, $GUI_FOCUS)
	GUICtrlSetResizing($idEdit, $GUI_DOCKBOTTOM + $GUI_DOCKHEIGHT)

	Local $idOK = GUICtrlCreateButton("OK", -1, 3, 75, 24) ; add the button that will close the GUI
	GUICtrlSetResizing($idOK, $GUI_DOCKBOTTOM + $GUI_DOCKSIZE + $GUI_DOCKHCENTER)

	Local $idCancel = GUICtrlCreateButton("Annuler", 25, -1) ; add the button that will close the GUI
	GUICtrlSetResizing($idCancel, $GUI_DOCKBOTTOM + $GUI_DOCKSIZE + $GUI_DOCKHCENTER)

	GUISetState(@SW_SHOW) ; to display the GUI

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

		EndSwitch
	WEnd
EndFunc   ;==>Example
