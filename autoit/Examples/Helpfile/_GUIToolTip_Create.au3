#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 270, 200)

	Local $idButton = GUICtrlCreateButton("Add", 30, 32, 75, 25)
	Local $hButton = GUICtrlGetHandle($idButton)
	Local $idClear = GUICtrlCreateButton("Clear", 30, 72, 75, 25)
	Local $hClear = GUICtrlGetHandle($idClear)
	Local $idMylist = GUICtrlCreateList("Item 1", 120, 32, 121, 97)
	Local $hMylist = GUICtrlGetHandle($idMylist)
	Local $idClose = GUICtrlCreateButton("Exit button", 80, 150, 110, 28)
	Local $hClose = GUICtrlGetHandle($idClose)

	; Create 2 tooltip controls
	Local $hToolTip1 = _GUIToolTip_Create(0, BitOR($_TT_ghTTDefaultStyle, $TTS_BALLOON)); balloon style tooltip
	Local $hToolTip2 = _GUIToolTip_Create(0) ; default style tooltip
	_GUIToolTip_SetMaxTipWidth($hToolTip2, 100) ; this allows multiline tooltips to be used with $hToolTip2
	; add tools to the tooltip controls
	_GUIToolTip_AddTool($hToolTip1, 0, "Adds an item to the list", $hButton)
	_GUIToolTip_AddTool($hToolTip1, 0, "Exit the script", $hClose)
	_GUIToolTip_AddTool($hToolTip1, 0, "The listbox", $hMylist)
	_GUIToolTip_AddTool($hToolTip2, 0, "Clears the list", $hClear)
	_GUIToolTip_AddTool($hToolTip2, 0, "Multiline tooltip" & @CRLF & "for the GUI", $hGUI) ; Multiline ToolTip
	GUISetState(@SW_SHOW)

	While 1
		Switch GUIGetMsg()
			Case $idButton
				GUICtrlSetData($idMylist, 'The Add button was pressed"|')
			Case $idClear
				GUICtrlSetData($idMylist, '')
			Case $idClose, $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd
	; Destroy the tooltip controls
	_GUIToolTip_Destroy($hToolTip1)
	_GUIToolTip_Destroy($hToolTip2)
	GUIDelete($hGUI)
EndFunc   ;==>Example
