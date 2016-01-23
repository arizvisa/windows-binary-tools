#include <GUIConstantsEx.au3>
#include <GuiTreeView.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

; Warning do not use SetItemParam on items created with GUICtrlCreateTreeViewItem
; Param is the controlID for items created with the built-in function

Example_Internal()

Func Example_Internal()
	Local $aidItem[10], $aidItemChild[30], $iYIndex = 0, $iRand, $idTreeView
	Local $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $TVS_CHECKBOXES)

	GUICreate("TreeView Get Item Param", 400, 300)

	$idTreeView = GUICtrlCreateTreeView(2, 2, 396, 268, $iStyle, $WS_EX_CLIENTEDGE)
	GUISetState(@SW_SHOW)

	_GUICtrlTreeView_BeginUpdate($idTreeView)
	For $x = 0 To 9
		$aidItem[$x] = GUICtrlCreateTreeViewItem(StringFormat("[%02d] New Item", $x), $idTreeView)
		For $y = $iYIndex To $iYIndex + 2
			$aidItemChild[$y] = GUICtrlCreateTreeViewItem(StringFormat("[%02d] New Child Item", $y), $aidItem[$x])
		Next
		$iYIndex += 3
	Next
	_GUICtrlTreeView_EndUpdate($idTreeView)

	$iRand = Random(0, 9, 1)
	MsgBox($MB_SYSTEMMODAL, "Information", StringFormat("Item Param/ID for index %d: %s\r\nIsPtr = %d IsHWnd = %d", $iRand, _GUICtrlTreeView_GetItemParam($idTreeView, $aidItem[$iRand]), _
			IsPtr(_GUICtrlTreeView_GetItemHandle($idTreeView, $aidItem[$iRand])), IsHWnd(_GUICtrlTreeView_GetItemHandle($idTreeView, $aidItem[$iRand]))))
	$iRand = Random(0, 29, 1)
	MsgBox($MB_SYSTEMMODAL, "Information", StringFormat("Item Param/ID for child index %d: %s", $iRand, _GUICtrlTreeView_GetItemParam($idTreeView, $aidItemChild[$iRand])))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example_Internal
