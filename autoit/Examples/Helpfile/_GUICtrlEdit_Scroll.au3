#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <GuiStatusBar.au3>
#include <MsgBoxConstants.au3>
#include <ScrollBarsConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $idEdit, $sText, $iLen

	; Create GUI
	GUICreate("Edit Scroll", 400, 300)
	$idEdit = GUICtrlCreateEdit("", 2, 2, 394, 268, BitOR($ES_WANTRETURN, $WS_VSCROLL))
	GUISetState(@SW_SHOW)

	; Set Text
	For $i = 1 To 50
		$sText &= $i & @CRLF
	Next
	_GUICtrlEdit_SetText($idEdit, $sText)

	MsgBox($MB_SYSTEMMODAL, "Information", "Scroll Line Down")
	_GUICtrlEdit_Scroll($idEdit, $SB_LINEDOWN)

	MsgBox($MB_SYSTEMMODAL, "Information", "Scroll Line Up")
	_GUICtrlEdit_Scroll($idEdit, $SB_LINEUP)

	MsgBox($MB_SYSTEMMODAL, "Information", "Scroll Page Down")
	_GUICtrlEdit_Scroll($idEdit, $SB_PAGEDOWN)

	MsgBox($MB_SYSTEMMODAL, "Information", "Scroll Page Up")
	_GUICtrlEdit_Scroll($idEdit, $SB_PAGEUP)

	$iLen = _GUICtrlEdit_GetTextLen($idEdit)
	_GUICtrlEdit_SetSel($idEdit, $iLen, $iLen)

	MsgBox($MB_SYSTEMMODAL, "Information", "Scroll Caret")
	_GUICtrlEdit_Scroll($idEdit, $SB_SCROLLCARET)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
