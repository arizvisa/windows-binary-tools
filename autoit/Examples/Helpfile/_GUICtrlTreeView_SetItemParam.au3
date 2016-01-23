#include <GUIConstantsEx.au3>
#include <GuiTreeView.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

; Warning do not use SetItemParam on items created with GUICtrlCreateTreeViewItem
; Param is the controlID for items created with the built-in function

Example()

Func Example()
	Local $hGUI, $ahItem[10], $ahItemChild[30], $iYIndex = 0, $iRand, $iParam = 1, $hTreeView
	Local $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $TVS_CHECKBOXES)

	$hGUI = GUICreate("(UDF Created) TreeView Set Item Param", 400, 300)

	$hTreeView = _GUICtrlTreeView_Create($hGUI, 2, 2, 396, 268, $iStyle, $WS_EX_CLIENTEDGE)
	GUISetState(@SW_SHOW)

	_GUICtrlTreeView_BeginUpdate($hTreeView)
	For $x = 0 To 9
		$ahItem[$x] = _GUICtrlTreeView_Add($hTreeView, 0, StringFormat("[%02d] New Item", $x))
		_GUICtrlTreeView_SetItemParam($hTreeView, $ahItem[$x], $iParam)
		$iParam += 1
		For $y = $iYIndex To $iYIndex + 2
			$ahItemChild[$y] = _GUICtrlTreeView_AddChild($hTreeView, $ahItem[$x], StringFormat("[%02d] New Item", $y))
			_GUICtrlTreeView_SetItemParam($hTreeView, $ahItemChild[$y], $iParam)
			$iParam += 1
		Next
		$iYIndex += 3
	Next
	_GUICtrlTreeView_EndUpdate($hTreeView)

	$iRand = Random(0, 9, 1)
	MsgBox($MB_SYSTEMMODAL, "Information", StringFormat("Item Param for index %d: %s", $iRand, _GUICtrlTreeView_GetItemParam($hTreeView, $ahItem[$iRand])))
	$iRand = Random(0, 29, 1)
	MsgBox($MB_SYSTEMMODAL, "Information", StringFormat("Item Param for child index %d: %s", $iRand, _GUICtrlTreeView_GetItemParam($hTreeView, $ahItemChild[$iRand])))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
