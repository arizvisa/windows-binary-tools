; ====================================================
; ============= Example of a child window ============
; ====================================================
; AutoIt version: 3.0.103
; Language:       English
; Author:         "SlimShady"
;
; ----------------------------------------------------------------------------
; Script Start
; ----------------------------------------------------------------------------

#include <GUIConstantsEx.au3>

_Main()

Func _Main()
	;Initialize variables
	Local $iGUIWidth = 250, $iGUIHeight = 250
	Local $hParentWin, $aParentWin_Pos, $hChildWin, $aMsg

	;Create main/parent window
	$hParentWin = GUICreate("Parent GUI", $iGUIWidth, $iGUIHeight)
	;Save the position of the parent window
	$aParentWin_Pos = WinGetPos($hParentWin, "")
	;Show the parent window/Make the parent window visible
	GUISetState(@SW_SHOW)

	;Create child window and add the parameter to make it the child of the parent window
	$hChildWin = GUICreate("Child GUI", $iGUIWidth, $iGUIHeight, $aParentWin_Pos[0] + 100, $aParentWin_Pos[1] + 100, -1, -1, $hParentWin)
	;Show the child window/Make the child window visible
	GUISetState(@SW_SHOW)

	;Switch to the parent window
	GUISwitch($hParentWin)

	;Loop until:
	;- user presses Esc when focused to the parent window
	;- user presses Alt+F4 when focused to the parent window
	;- user clicks the close button of the parent window
	While 1
		;After every loop check if the user clicked something in the GUI windows
		$aMsg = GUIGetMsg(1)
		Select
			;Check if user clicked on a close button of any of the 2 windows
			Case $aMsg[0] = $GUI_EVENT_CLOSE
				;Check if user clicked on the close button of the child window
				If $aMsg[1] = $hChildWin Then
					MsgBox(64, "Test", "Child GUI will now close.")
					;Switch to the child window
					GUISwitch($hChildWin)
					;Destroy the child GUI including the controls
					GUIDelete()
					;Check if user clicked on the close button of the parent window
				ElseIf $aMsg[1] = $hParentWin Then
					MsgBox(64, "Test", "Parent GUI will now close.")
					;Switch to the parent window
					GUISwitch($hParentWin)
					;Destroy the parent GUI including the controls
					GUIDelete()
					;Exit the script
					Exit
				EndIf

		EndSelect

	WEnd
EndFunc   ;==>_Main
