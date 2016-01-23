#include <GUIConstantsEx.au3>
#include <GuiTreeView.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $aidItem[6], $hRandomItem, $iRandIndex, $idTreeView
	Local $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $TVS_CHECKBOXES)

	GUICreate("TreeView Set Checked By Index", 400, 300)

	$idTreeView = GUICtrlCreateTreeView(2, 2, 396, 268, $iStyle, $WS_EX_CLIENTEDGE)
	GUISetState(@SW_SHOW)

	_GUICtrlTreeView_BeginUpdate($idTreeView)
	For $x = 0 To UBound($aidItem) - 1
		$aidItem[$x] = GUICtrlCreateTreeViewItem(StringFormat("[%02d] New Item", $x + 1), $idTreeView)
		For $y = 0 To 5
			GUICtrlCreateTreeViewItem(StringFormat("[%02d] New Child Item", $y + 1), $aidItem[$x])
		Next
	Next
	_GUICtrlTreeView_EndUpdate($idTreeView)

	$hRandomItem = Random(0, UBound($aidItem) - 1, 1)
	$iRandIndex = Random(0, 5, 1)
	MsgBox($MB_SYSTEMMODAL, "Information", _
			StringFormat("Set Child Item index[%d] of Item Index[%d]: %s", $iRandIndex, $hRandomItem, _
			_GUICtrlTreeView_SetCheckedByIndex($idTreeView, $aidItem[$hRandomItem], $iRandIndex)))
	_GUICtrlTreeView_Expand($idTreeView)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
