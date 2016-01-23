#include <GUIConstantsEx.au3>
#include <GuiTreeView.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $aidItem[10], $aidChildItem[30], $iYItem = 0, $iRand, $hInsert, $idTreeView
	Local $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS)

	GUICreate("TreeView Insert Item", 400, 300)

	$idTreeView = GUICtrlCreateTreeView(2, 2, 396, 268, $iStyle, $WS_EX_CLIENTEDGE)
	GUISetState(@SW_SHOW)

	_GUICtrlTreeView_BeginUpdate($idTreeView)
	For $x = 0 To 9
		$aidItem[$x] = GUICtrlCreateTreeViewItem(StringFormat("[%02d] New Item", $x), $idTreeView)
		For $y = 1 To 3
			$aidChildItem[$iYItem] = GUICtrlCreateTreeViewItem(StringFormat("[%02d] New Child", $iYItem), $aidItem[$x])
			$iYItem += 1
		Next
	Next
	_GUICtrlTreeView_EndUpdate($idTreeView)

	$iRand = Random(0, 9, 1)
	MsgBox($MB_SYSTEMMODAL, "Information", StringFormat("Inserted after index %d: %s", $iRand, _GUICtrlTreeView_InsertItem($idTreeView, "Inserted Item", 0, $aidItem[$iRand])))

	$iRand = Random(0, 29, 1)
	$hInsert = _GUICtrlTreeView_InsertItem($idTreeView, "Inserted Item", _GUICtrlTreeView_GetParentHandle($idTreeView, $aidChildItem[$iRand]), $aidChildItem[$iRand])
	MsgBox($MB_SYSTEMMODAL, "Information", StringFormat("Inserted after child index %d: %s", $iRand, $hInsert))

	$hInsert = _GUICtrlTreeView_InsertItem($idTreeView, "Inserted first child Item", _GUICtrlTreeView_GetParentHandle($idTreeView, $aidChildItem[$iRand]), $TVI_FIRST)
	MsgBox($MB_SYSTEMMODAL, "Information", StringFormat("Inserted child index %d firsts: %s", $iRand, $hInsert))
	_GUICtrlTreeView_SelectItem($idTreeView, $hInsert)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
