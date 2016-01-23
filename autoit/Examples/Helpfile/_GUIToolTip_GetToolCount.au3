#include <GUIConstantsEx.au3>
#include <GUIToolTip.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI = GUICreate(StringTrimRight(@ScriptName, StringLen(".exe")), 270, 200)

	Local $idAdd = GUICtrlCreateButton("Get Count 1", 30, 32, 75, 25)
	Local $hAdd = GUICtrlGetHandle($idAdd)
	Local $idClear = GUICtrlCreateButton("Get Count 2", 30, 72, 75, 25)
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
	; 3 tools for $hToolTip1
	_GUIToolTip_AddTool($hToolTip1, 0, "Click to display the # of tools assigned to $hToolTip1", $hAdd)
	_GUIToolTip_AddTool($hToolTip1, 0, "Exit the script", $hClose)
	_GUIToolTip_AddTool($hToolTip1, 0, "The listbox", $hMylist)
	; 2 tools for $hToolTip2
	_GUIToolTip_AddTool($hToolTip2, 0, "Click to display the # of tools assigned to $hToolTip2", $hClear)
	_GUIToolTip_AddTool($hToolTip2, 0, "Multiline tooltip" & @CRLF & "for the GUI", $hGUI) ; Multiline ToolTip
	GUISetState(@SW_SHOW)

	While 1
		Switch GUIGetMsg()
			Case $idAdd
				MsgBox($MB_SYSTEMMODAL, "Tool count", "Number of tools:" & @TAB & _GUIToolTip_GetToolCount($hToolTip1))
			Case $idClear
				MsgBox($MB_SYSTEMMODAL, "Tool count", "Number of tools:" & @TAB & _GUIToolTip_GetToolCount($hToolTip2))
			Case $idClose, $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd
	; Destroy the tooltip controls
	_GUIToolTip_Destroy($hToolTip1)
	_GUIToolTip_Destroy($hToolTip2)
	GUIDelete($hGUI)
EndFunc   ;==>Example
