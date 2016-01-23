#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <GuiStatusBar.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $hStatusBar, $idEdit, $hGUI
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"
	Local $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\include\_ReadMe_.txt"
	Local $aPartRightSide[6] = [50, 130, 210, 290, 378, -1], $tRECT

	; Create GUI
	$hGUI = GUICreate("Edit Get RECTEx", 400, 300)
	$idEdit = GUICtrlCreateEdit("", 2, 2, 394, 268, BitOR($ES_WANTRETURN, $WS_VSCROLL))
	$hStatusBar = _GUICtrlStatusBar_Create($hGUI, $aPartRightSide)
	_GUICtrlStatusBar_SetIcon($hStatusBar, 5, 97, "shell32.dll")
	_GUICtrlStatusBar_SetText($hStatusBar, "Rect")
	GUISetState(@SW_SHOW)

	; Get RectEx
	$tRECT = _GUICtrlEdit_GetRECTEx($idEdit)
	DllStructSetData($tRECT, "Left", DllStructGetData($tRECT, "Left") + 10)
	DllStructSetData($tRECT, "Top", DllStructGetData($tRECT, "Top") + 10)
	DllStructSetData($tRECT, "Right", DllStructGetData($tRECT, "Right") - 10)
	DllStructSetData($tRECT, "Bottom", DllStructGetData($tRECT, "Bottom") - 10)

	; Set RectEx
	_GUICtrlEdit_SetRECTEx($idEdit, $tRECT)

	; Add Text
	_GUICtrlEdit_AppendText($idEdit, FileRead($sFile))
	_GUICtrlEdit_LineScroll($idEdit, 0, _GUICtrlEdit_GetLineCount($idEdit) * -1)

	; Get RectEx
	$tRECT = _GUICtrlEdit_GetRECTEx($idEdit)
	_GUICtrlStatusBar_SetText($hStatusBar, "Left: " & DllStructGetData($tRECT, "Left"), 1)
	_GUICtrlStatusBar_SetText($hStatusBar, "Topt: " & DllStructGetData($tRECT, "Top"), 2)
	_GUICtrlStatusBar_SetText($hStatusBar, "Right: " & DllStructGetData($tRECT, "Right"), 3)
	_GUICtrlStatusBar_SetText($hStatusBar, "Bottom: " & DllStructGetData($tRECT, "Bottom"), 4)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
