#include <GUIConstantsEx.au3>
#include <GuiTreeView.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $aidItem[100], $aidChildItem[100], $iRand, $iChildRand, $iYItem, $idTreeView
	Local $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $TVS_CHECKBOXES)

	GUICreate("TreeView Get Sibling Count", 400, 300)

	$idTreeView = GUICtrlCreateTreeView(2, 2, 396, 268, $iStyle, $WS_EX_CLIENTEDGE)
	GUISetState(@SW_SHOW)

	_GUICtrlTreeView_BeginUpdate($idTreeView)
	$iRand = Random(2, 9, 1)
	For $x = 0 To $iRand
		$aidItem[$x] = GUICtrlCreateTreeViewItem(StringFormat("[%02d] New Item", $x), $idTreeView)
		$iChildRand = Random(0, 9, 1)
		For $y = 0 To $iChildRand
			$aidChildItem[$iYItem] = GUICtrlCreateTreeViewItem(StringFormat("[%02d] New Item", $y), $aidItem[$x])
			$iYItem += 1
		Next
	Next
	_GUICtrlTreeView_EndUpdate($idTreeView)

	$iRand = Random(0, 9)
	MsgBox($MB_SYSTEMMODAL, "Information", StringFormat("Sibling Count for item index %d: %d", $iRand, _GUICtrlTreeView_GetSiblingCount($idTreeView, $aidItem[$iRand])))

	$iRand = Random(0, 99)
	MsgBox($MB_SYSTEMMODAL, "Information", StringFormat("Sibling Count for Child item index %d: %d", $iRand, _GUICtrlTreeView_GetSiblingCount($idTreeView, $aidChildItem[$iRand])))
	_GUICtrlTreeView_Expand($idTreeView, _GUICtrlTreeView_GetParentHandle($idTreeView, $aidChildItem[$iRand]))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
