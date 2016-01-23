#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <GuiStatusBar.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $hStatusBar, $idEdit, $hGUI, $iRandom
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"
	Local $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\include\_ReadMe_.txt"

	; Create GUI
	$hGUI = GUICreate("Edit Line From Char", 400, 300)
	$idEdit = GUICtrlCreateEdit("", 2, 2, 394, 268, BitOR($ES_WANTRETURN, $WS_VSCROLL))
	$hStatusBar = _GUICtrlStatusBar_Create($hGUI)
	GUISetState(@SW_SHOW)

	; Set Text
	_GUICtrlEdit_SetText($idEdit, FileRead($sFile))

	; Line From Char
	$iRandom = Random(0, _GUICtrlEdit_GetTextLen($idEdit) - 1, 1)
	_GUICtrlEdit_SetSel($idEdit, $iRandom - 1, $iRandom)
	_GUICtrlStatusBar_SetText($hStatusBar, "Character  " & $iRandom & " is in a line: " & _GUICtrlEdit_LineFromChar($idEdit, $iRandom))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
