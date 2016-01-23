#include <GUIConstantsEx.au3>
#include <GuiImageList.au3>
#include <GuiListView.au3>
#include <WindowsConstants.au3>

Global $g_hListView

Example()

Func Example()
	Local $hGUI, $hImage
	$hGUI = GUICreate("(UDF Created) ListView Create", 400, 300)

	$g_hListView = _GUICtrlListView_Create($hGUI, "", 2, 2, 394, 268)
	_GUICtrlListView_SetExtendedListViewStyle($g_hListView, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES))
	GUISetState(@SW_SHOW)

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	; Load images
	$hImage = _GUIImageList_Create()
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($g_hListView, 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($g_hListView, 0x00FF00, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($g_hListView, 0x0000FF, 16, 16))
	_GUICtrlListView_SetImageList($g_hListView, $hImage, 1)

	; Add columns
	_GUICtrlListView_InsertColumn($g_hListView, 0, "Column 1", 100)
	_GUICtrlListView_InsertColumn($g_hListView, 1, "Column 2", 100)
	_GUICtrlListView_InsertColumn($g_hListView, 2, "Column 3", 100)

	; Add items
	_GUICtrlListView_AddItem($g_hListView, "Row 1: Col 1", 0)
	_GUICtrlListView_AddSubItem($g_hListView, 0, "Row 1: Col 2", 1)
	_GUICtrlListView_AddSubItem($g_hListView, 0, "Row 1: Col 3", 2)
	_GUICtrlListView_AddItem($g_hListView, "Row 2: Col 1", 1)
	_GUICtrlListView_AddSubItem($g_hListView, 1, "Row 2: Col 2", 1)
	_GUICtrlListView_AddItem($g_hListView, "Row 3: Col 1", 2)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

Func WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndListView, $tInfo
	; Local $tBuffer
	$hWndListView = $g_hListView
	If Not IsHWnd($g_hListView) Then $hWndListView = GUICtrlGetHandle($g_hListView)

	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hWndListView
			Switch $iCode
				; Case $LVN_BEGINDRAG ; A drag-and-drop operation involving the left mouse button is being initiated
				; $tInfo = DllStructCreate($tagNMLISTVIEW, $lParam)
				; _DebugPrint("$LVN_BEGINDRAG" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
				; "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
				; "-->Code:" & @TAB & $iCode & @CRLF & _
				; "-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @CRLF & _
				; "-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
				; "-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
				; "-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
				; "-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
				; "-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
				; "-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
				; "-->Param:" & @TAB & DllStructGetData($tInfo, "Param"))
				; ; No return value
				; Case $LVN_BEGINLABELEDIT ; Start of label editing for an item
				; $tInfo = DllStructCreate($tagNMLVDISPINFO, $lParam)
				; _DebugPrint("$LVN_BEGINLABELEDIT" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
				; "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
				; "-->Code:" & @TAB & $iCode & @CRLF & _
				; "-->Mask:" & @TAB & DllStructGetData($tInfo, "Mask") & @CRLF & _
				; "-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @CRLF & _
				; "-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
				; "-->State:" & @TAB & DllStructGetData($tInfo, "State") & @CRLF & _
				; "-->StateMask:" & @TAB & DllStructGetData($tInfo, "StateMask") & @CRLF & _
				; "-->Image:" & @TAB & DllStructGetData($tInfo, "Image") & @CRLF & _
				; "-->Param:" & @TAB & DllStructGetData($tInfo, "Param") & @CRLF & _
				; "-->Indent:" & @TAB & DllStructGetData($tInfo, "Indent") & @CRLF & _
				; "-->GroupID:" & @TAB & DllStructGetData($tInfo, "GroupID") & @CRLF & _
				; "-->Columns:" & @TAB & DllStructGetData($tInfo, "Columns") & @CRLF & _
				; "-->pColumns:" & @TAB & DllStructGetData($tInfo, "pColumns"))
				; Return False ; Allow the user to edit the label
				; ;Return True  ; Prevent the user from editing the label
				; Case $LVN_BEGINRDRAG ; A drag-and-drop operation involving the right mouse button is being initiated
				; $tInfo = DllStructCreate($tagNMLISTVIEW, $lParam)
				; _DebugPrint("$LVN_BEGINRDRAG" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
				; "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
				; "-->Code:" & @TAB & $iCode & @CRLF & _
				; "-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @CRLF & _
				; "-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
				; "-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
				; "-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
				; "-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
				; "-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
				; "-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
				; "-->Param:" & @TAB & DllStructGetData($tInfo, "Param"))
				; ; No return value
				; Case $LVN_BEGINSCROLL ; A scrolling operation starts, Minium OS WinXP
				; $tInfo = DllStructCreate($tagNMLVSCROLL, $lParam)
				; _DebugPrint("$LVN_BEGINSCROLL" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
				; "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
				; "-->Code:" & @TAB & $iCode & @CRLF & _
				; "-->DX:" & @TAB & DllStructGetData($tInfo, "DX") & @CRLF & _
				; "-->DY:" & @TAB & DllStructGetData($tInfo, "DY"))
				; ; No return value
				Case $LVN_COLUMNCLICK ; A column was clicked
					$tInfo = DllStructCreate($tagNMLISTVIEW, $lParam)
					_DebugPrint("$LVN_COLUMNCLICK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @CRLF & _
							"-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
							"-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
							"-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
							"-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
							"-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
							"-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
							"-->Param:" & @TAB & DllStructGetData($tInfo, "Param"))
					; No return value
					; Case $LVN_DELETEALLITEMS ; All items in the control are about to be deleted
					; $tInfo = DllStructCreate($tagNMLISTVIEW, $lParam)
					; _DebugPrint("$LVN_DELETEALLITEMS" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
					; "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
					; "-->Code:" & @TAB & $iCode & @CRLF & _
					; "-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @CRLF & _
					; "-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
					; "-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
					; "-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
					; "-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
					; "-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
					; "-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
					; "-->Param:" & @TAB & DllStructGetData($tInfo, "Param"))
					; Return True ; To suppress subsequent $LVN_DELETEITEM messages
					; ;Return False ; To receive subsequent $LVN_DELETEITEM messages
					; Case $LVN_DELETEITEM ; An item is about to be deleted
					; $tInfo = DllStructCreate($tagNMLISTVIEW, $lParam)
					; _DebugPrint("$LVN_DELETEITEM" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
					; "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
					; "-->Code:" & @TAB & $iCode & @CRLF & _
					; "-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @CRLF & _
					; "-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
					; "-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
					; "-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
					; "-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
					; "-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
					; "-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
					; "-->Param:" & @TAB & DllStructGetData($tInfo, "Param"))
					; ; No return value
					; Case $LVN_ENDLABELEDIT ; The end of label editing for an item
					; $tInfo = DllStructCreate($tagNMLVDISPINFO, $lParam)
					; $tBuffer = DllStructCreate("char Text[" & DllStructGetData($tInfo, "TextMax") & "]", DllStructGetData($tInfo, "Text"))
					; _DebugPrint("$LVN_ENDLABELEDIT" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
					; "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
					; "-->Code:" & @TAB & $iCode & @CRLF & _
					; "-->Mask:" & @TAB & DllStructGetData($tInfo, "Mask") & @CRLF & _
					; "-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @CRLF & _
					; "-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
					; "-->State:" & @TAB & DllStructGetData($tInfo, "State") & @CRLF & _
					; "-->StateMask:" & @TAB & DllStructGetData($tInfo, "StateMask") & @CRLF & _
					; "-->Text:" & @TAB & DllStructGetData($tBuffer, "Text") & @CRLF & _
					; "-->TextMax:" & @TAB & DllStructGetData($tInfo, "TextMax") & @CRLF & _
					; "-->Image:" & @TAB & DllStructGetData($tInfo, "Image") & @CRLF & _
					; "-->Param:" & @TAB & DllStructGetData($tInfo, "Param") & @CRLF & _
					; "-->Indent:" & @TAB & DllStructGetData($tInfo, "Indent") & @CRLF & _
					; "-->GroupID:" & @TAB & DllStructGetData($tInfo, "GroupID") & @CRLF & _
					; "-->Columns:" & @TAB & DllStructGetData($tInfo, "Columns") & @CRLF & _
					; "-->pColumns:" & @TAB & DllStructGetData($tInfo, "pColumns"))
					; ; If Text is not empty, return True to set the item's label to the edited text, return false to reject it
					; ; If Text is empty the return value is ignored
					; Return True
					; Case $LVN_ENDSCROLL ; A scrolling operation ends, Minium OS WinXP
					; $tInfo = DllStructCreate($tagNMLVSCROLL, $lParam)
					; _DebugPrint("$LVN_ENDSCROLL" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
					; "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
					; "-->Code:" & @TAB & $iCode & @CRLF & _
					; "-->DX:" & @TAB & DllStructGetData($tInfo, "DX") & @CRLF & _
					; "-->DY:" & @TAB & DllStructGetData($tInfo, "DY"))
					; ; No return value
					; Case $LVN_GETDISPINFO ; Provide information needed to display or sort a list-view item
					; $tInfo = DllStructCreate($tagNMLVDISPINFO, $lParam)
					; $tBuffer = DllStructCreate("char Text[" & DllStructGetData($tInfo, "TextMax") & "]", DllStructGetData($tInfo, "Text"))
					; _DebugPrint("$LVN_GETDISPINFO" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
					; "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
					; "-->Code:" & @TAB & $iCode & @CRLF & _
					; "-->Mask:" & @TAB & DllStructGetData($tInfo, "Mask") & @CRLF & _
					; "-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @CRLF & _
					; "-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
					; "-->State:" & @TAB & DllStructGetData($tInfo, "State") & @CRLF & _
					; "-->StateMask:" & @TAB & DllStructGetData($tInfo, "StateMask") & @CRLF & _
					; "-->Text:" & @TAB & DllStructGetData($tBuffer, "Text") & @CRLF & _
					; "-->TextMax:" & @TAB & DllStructGetData($tInfo, "TextMax") & @CRLF & _
					; "-->Image:" & @TAB & DllStructGetData($tInfo, "Image") & @CRLF & _
					; "-->Param:" & @TAB & DllStructGetData($tInfo, "Param") & @CRLF & _
					; "-->Indent:" & @TAB & DllStructGetData($tInfo, "Indent") & @CRLF & _
					; "-->GroupID:" & @TAB & DllStructGetData($tInfo, "GroupID") & @CRLF & _
					; "-->Columns:" & @TAB & DllStructGetData($tInfo, "Columns") & @CRLF & _
					; "-->pColumns:" & @TAB & DllStructGetData($tInfo, "pColumns"))
					; ; No return value
					; Case $LVN_GETINFOTIP ; Sent by a large icon view list-view control that has the $LVS_EX_INFOTIP extended style
					; $tInfo = DllStructCreate($tagNMLVGETINFOTIP, $lParam)
					; $tBuffer = DllStructCreate("char Text[" & DllStructGetData($tInfo, "TextMax") & "]", DllStructGetData($tInfo, "Text"))
					; _DebugPrint("$LVN_GETINFOTIP" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
					; "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
					; "-->Code:" & @TAB & $iCode & @CRLF & _
					; "-->Flags:" & @TAB & DllStructGetData($tInfo, "Flags") & @CRLF & _
					; "-->Text:" & @TAB & DllStructGetData($tBuffer, "Text") & @CRLF & _
					; "-->TextMax:" & @TAB & DllStructGetData($tInfo, "TextMax") & @CRLF & _
					; "-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @CRLF & _
					; "-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
					; "-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam"))
					; ; No return value
					; Case $LVN_HOTTRACK ; Sent by a list-view control when the user moves the mouse over an item
					; $tInfo = DllStructCreate($tagNMLISTVIEW, $lParam)
					; _DebugPrint("$LVN_HOTTRACK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
					; "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
					; "-->Code:" & @TAB & $iCode & @CRLF & _
					; "-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @CRLF & _
					; "-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
					; "-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
					; "-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
					; "-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
					; "-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
					; "-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
					; "-->Param:" & @TAB & DllStructGetData($tInfo, "Param"))
					; Return 0 ; allow the list view to perform its normal track select processing.
					; ;Return 1 ; the item will not be selected.
					; Case $LVN_INSERTITEM ; A new item was inserted
					; $tInfo = DllStructCreate($tagNMLISTVIEW, $lParam)
					; _DebugPrint("$LVN_INSERTITEM" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
					; "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
					; "-->Code:" & @TAB & $iCode & @CRLF & _
					; "-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @CRLF & _
					; "-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
					; "-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
					; "-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
					; "-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
					; "-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
					; "-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
					; "-->Param:" & @TAB & DllStructGetData($tInfo, "Param"))
					; ; No return value
					; Case $LVN_ITEMACTIVATE ; Sent by a list-view control when the user activates an item
					; $tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
					; _DebugPrint("$LVN_ITEMACTIVATE" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
					; "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
					; "-->Code:" & @TAB & $iCode & @CRLF & _
					; "-->Index:" & @TAB & DllStructGetData($tInfo, "Index") & @CRLF & _
					; "-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
					; "-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
					; "-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
					; "-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
					; "-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
					; "-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
					; "-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @CRLF & _
					; "-->KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags"))
					; Return 0
					; Case $LVN_ITEMCHANGED ; An item has changed
					; $tInfo = DllStructCreate($tagNMLISTVIEW, $lParam)
					; _DebugPrint("$LVN_ITEMCHANGED" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
					; "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
					; "-->Code:" & @TAB & $iCode & @CRLF & _
					; "-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @CRLF & _
					; "-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
					; "-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
					; "-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
					; "-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
					; "-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
					; "-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
					; "-->Param:" & @TAB & DllStructGetData($tInfo, "Param"))
					; ; No return value
					; Case $LVN_ITEMCHANGING ; An item is changing
					; $tInfo = DllStructCreate($tagNMLISTVIEW, $lParam)
					; _DebugPrint("$LVN_ITEMCHANGING" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
					; "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
					; "-->Code:" & @TAB & $iCode & @CRLF & _
					; "-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @CRLF & _
					; "-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
					; "-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
					; "-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
					; "-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
					; "-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
					; "-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
					; "-->Param:" & @TAB & DllStructGetData($tInfo, "Param"))
					; Return True ; prevent the change
					; ;Return False ; allow the change
				Case $LVN_KEYDOWN ; A key has been pressed
					$tInfo = DllStructCreate($tagNMLVKEYDOWN, $lParam)
					_DebugPrint("$LVN_KEYDOWN" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->VKey:" & @TAB & DllStructGetData($tInfo, "VKey") & @CRLF & _
							"-->Flags:" & @TAB & DllStructGetData($tInfo, "Flags"))
					; No return value
					; Case $LVN_MARQUEEBEGIN ; A bounding box (marquee) selection has begun
					; _DebugPrint("$LVN_MARQUEEBEGIN" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
					; "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
					; "-->Code:" & @TAB & $iCode)
					; Return 0 ; accept the message
					; ;Return 1 ; quit the bounding box selection
					; Case $LVN_SETDISPINFO ; Update the information it maintains for an item
					; $tInfo = DllStructCreate($tagNMLVDISPINFO, $lParam)
					; $tBuffer = DllStructCreate("char Text[" & DllStructGetData($tInfo, "TextMax") & "]", DllStructGetData($tInfo, "Text"))
					; _DebugPrint("$LVN_SETDISPINFO" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
					; "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
					; "-->Code:" & @TAB & $iCode & @CRLF & _
					; "-->Mask:" & @TAB & DllStructGetData($tInfo, "Mask") & @CRLF & _
					; "-->Item:" & @TAB & DllStructGetData($tInfo, "Item") & @CRLF & _
					; "-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
					; "-->State:" & @TAB & DllStructGetData($tInfo, "State") & @CRLF & _
					; "-->StateMask:" & @TAB & DllStructGetData($tInfo, "StateMask") & @CRLF & _
					; "-->Text:" & @TAB & DllStructGetData($tBuffer, "Text") & @CRLF & _
					; "-->TextMax:" & @TAB & DllStructGetData($tInfo, "TextMax") & @CRLF & _
					; "-->Image:" & @TAB & DllStructGetData($tInfo, "Image") & @CRLF & _
					; "-->Param:" & @TAB & DllStructGetData($tInfo, "Param") & @CRLF & _
					; "-->Indent:" & @TAB & DllStructGetData($tInfo, "Indent") & @CRLF & _
					; "-->GroupID:" & @TAB & DllStructGetData($tInfo, "GroupID") & @CRLF & _
					; "-->Columns:" & @TAB & DllStructGetData($tInfo, "Columns") & @CRLF & _
					; "-->pColumns:" & @TAB & DllStructGetData($tInfo, "pColumns"))
					; ; No return value
				Case $NM_CLICK ; Sent by a list-view control when the user clicks an item with the left mouse button
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
					_DebugPrint("$NM_CLICK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->Index:" & @TAB & DllStructGetData($tInfo, "Index") & @CRLF & _
							"-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
							"-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
							"-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
							"-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
							"-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
							"-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
							"-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @CRLF & _
							"-->KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags"))
					; No return value
				Case $NM_DBLCLK ; Sent by a list-view control when the user double-clicks an item with the left mouse button
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
					_DebugPrint("$NM_DBLCLK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->Index:" & @TAB & DllStructGetData($tInfo, "Index") & @CRLF & _
							"-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
							"-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
							"-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
							"-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
							"-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
							"-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
							"-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @CRLF & _
							"-->KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags"))
					; No return value
					; Case $NM_HOVER ; Sent by a list-view control when the mouse hovers over an item
					; _DebugPrint("$NM_HOVER" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
					; "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
					; "-->Code:" & @TAB & $iCode)
					; Return 0 ; process the hover normally
					; ;Return 1 ; prevent the hover from being processed
				Case $NM_KILLFOCUS ; The control has lost the input focus
					_DebugPrint("$NM_KILLFOCUS" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; No return value
				Case $NM_RCLICK ; Sent by a list-view control when the user clicks an item with the right mouse button
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
					_DebugPrint("$NM_RCLICK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->Index:" & @TAB & DllStructGetData($tInfo, "Index") & @CRLF & _
							"-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
							"-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
							"-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
							"-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
							"-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
							"-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
							"-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @CRLF & _
							"-->KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags"))
					;Return 1 ; not to allow the default processing
					Return 0 ; allow the default processing
				Case $NM_RDBLCLK ; Sent by a list-view control when the user double-clicks an item with the right mouse button
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
					_DebugPrint("$NM_RDBLCLK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->Index:" & @TAB & DllStructGetData($tInfo, "Index") & @CRLF & _
							"-->SubItem:" & @TAB & DllStructGetData($tInfo, "SubItem") & @CRLF & _
							"-->NewState:" & @TAB & DllStructGetData($tInfo, "NewState") & @CRLF & _
							"-->OldState:" & @TAB & DllStructGetData($tInfo, "OldState") & @CRLF & _
							"-->Changed:" & @TAB & DllStructGetData($tInfo, "Changed") & @CRLF & _
							"-->ActionX:" & @TAB & DllStructGetData($tInfo, "ActionX") & @CRLF & _
							"-->ActionY:" & @TAB & DllStructGetData($tInfo, "ActionY") & @CRLF & _
							"-->lParam:" & @TAB & DllStructGetData($tInfo, "lParam") & @CRLF & _
							"-->KeyFlags:" & @TAB & DllStructGetData($tInfo, "KeyFlags"))
					; No return value
				Case $NM_RETURN ; The control has the input focus and that the user has pressed the ENTER key
					_DebugPrint("$NM_RETURN" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; No return value
				Case $NM_SETFOCUS ; The control has received the input focus
					_DebugPrint("$NM_SETFOCUS" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; No return value
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _DebugPrint($s_Text, $sLine = @ScriptLineNumber)
	ConsoleWrite( _
			"!===========================================================" & @CRLF & _
			"+======================================================" & @CRLF & _
			"-->Line(" & StringFormat("%04d", $sLine) & "):" & @TAB & $s_Text & @CRLF & _
			"+======================================================" & @CRLF)
EndFunc   ;==>_DebugPrint
