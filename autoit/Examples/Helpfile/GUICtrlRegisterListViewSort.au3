; sorting 3 column's different

#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>

Global $g_iCurCol = -1
Global $g_iSortDir = 1
Global $g_bSet = False
Global $g_iCol = -1

Example()

Func Example()
	GUICreate("Test", 300, 200)

	Local $idLv = GUICtrlCreateListView("Column1|Col2|Col3", 10, 10, 280, 180)
	GUICtrlRegisterListViewSort(-1, "LVSort") ; Register the function "SortLV" for the sorting callback

	GUICtrlCreateListViewItem("ABC|666|10.05.2004", $idLv)
	GUICtrlSetImage(-1, "shell32.dll", 7)
	GUICtrlCreateListViewItem("DEF|444|11.05.2005", $idLv)
	GUICtrlSetImage(-1, "shell32.dll", 12)
	GUICtrlCreateListViewItem("CDE|444|12.05.2004", $idLv)
	GUICtrlSetImage(-1, "shell32.dll", 3)

	GUISetState(@SW_SHOW)

	Local $idMsg
	; Loop until the user exits.
	While 1
		$idMsg = GUIGetMsg()
		Switch $idMsg
			Case $GUI_EVENT_CLOSE
				ExitLoop

			Case $idLv
				$g_bSet = False
				$g_iCurCol = $g_iCol
				GUICtrlSendMsg($idLv, $LVM_SETSELECTEDCOLUMN, GUICtrlGetState($idLv), 0)
		EndSwitch
	WEnd

	GUIDelete()
EndFunc   ;==>Example

; Our sorting callback funtion
Func LVSort($hWnd, $nItem1, $nItem2, $iColumn)
	Local $sVal1, $sVal2, $iResult

	; Switch the sorting direction
	If $iColumn = $g_iCurCol Then
		If Not $g_bSet Then
			$g_iSortDir = $g_iSortDir * -1
			$g_bSet = True
		EndIf
	Else
		$g_iSortDir = 1
	EndIf
	$g_iCol = $iColumn

	$sVal1 = GetSubItemText($hWnd, $nItem1, $iColumn)
	$sVal2 = GetSubItemText($hWnd, $nItem2, $iColumn)

	; If it is the 3rd colum (column starts with 0) then compare the dates
	If $iColumn = 2 Then
		$sVal1 = StringRight($sVal1, 4) & StringMid($sVal1, 4, 2) & StringLeft($sVal1, 2)
		$sVal2 = StringRight($sVal2, 4) & StringMid($sVal2, 4, 2) & StringLeft($sVal2, 2)
	EndIf

	$iResult = 0 ; No change of item1 and item2 positions

	If $sVal1 < $sVal2 Then
		$iResult = -1 ; Put item2 before item1
	ElseIf $sVal1 > $sVal2 Then
		$iResult = 1 ; Put item2 behind item1
	EndIf

	$iResult = $iResult * $g_iSortDir

	Return $iResult
EndFunc   ;==>LVSort

; Retrieve the text of a listview item in a specified column
Func GetSubItemText($idCtrl, $idItem, $iColumn)
	Local $tLvfi = DllStructCreate("uint;ptr;int;int[2];int")

	DllStructSetData($tLvfi, 1, $LVFI_PARAM)
	DllStructSetData($tLvfi, 3, $idItem)

	Local $tBuffer = DllStructCreate("char[260]")

	Local $nIndex = GUICtrlSendMsg($idCtrl, $LVM_FINDITEM, -1, DllStructGetPtr($tLvfi));

	Local $tLvi = DllStructCreate("uint;int;int;uint;uint;ptr;int;int;int;int")

	DllStructSetData($tLvi, 1, $LVIF_TEXT)
	DllStructSetData($tLvi, 2, $nIndex)
	DllStructSetData($tLvi, 3, $iColumn)
	DllStructSetData($tLvi, 6, DllStructGetPtr($tBuffer))
	DllStructSetData($tLvi, 7, 260)

	GUICtrlSendMsg($idCtrl, $LVM_GETITEMA, 0, DllStructGetPtr($tLvi));

	Local $sItemText = DllStructGetData($tBuffer, 1)

	Return $sItemText
EndFunc   ;==>GetSubItemText
