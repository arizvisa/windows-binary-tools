#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $idEdit
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"
	Local $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\include\_ReadMe_.txt"
	Local $sBefore, $sAfter

	; Create GUI
	GUICreate("Edit FmtLines", 400, 300)
	$idEdit = GUICtrlCreateEdit("", 2, 2, 394, 268, BitOR($ES_WANTRETURN, $WS_VSCROLL))
	GUISetState(@SW_SHOW)

	; Set Text
	_GUICtrlEdit_SetText($idEdit, FileRead($sFile, 500))

	; Text retrieved in default format
	$sBefore = _GUICtrlEdit_GetText($idEdit)

	; insert soft line-breaks
	_GUICtrlEdit_FmtLines($idEdit, True)

	; Text with soft line breaks
	$sAfter = _GUICtrlEdit_GetText($idEdit)

	MsgBox($MB_SYSTEMMODAL, "Information", "Before:" & @CRLF & @CRLF & $sBefore & @CRLF & _
			'--------------------------------------------------------------' & @CRLF & _
			"After:" & @CRLF & @CRLF & $sAfter)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
