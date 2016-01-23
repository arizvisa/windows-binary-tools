#include <GUIConstantsEx.au3>
#include <GuiImageList.au3>
#include <GuiListView.au3>
#include <WindowsConstants.au3>

#Region Globals *************************************************************************
Global $g_ahDragImageList, $g_hListView, $g_bDragging = False, $g_iLV_Height
Global $g_aIndex[2] ; from and to

Global Const $g_iDebugIt = 1

#EndRegion Globals *************************************************************************

Opt("WinTitleMatchMode", 2)

Example()

Func Example()
	Local Const $iImage_width = 20
	Local Const $iImage_height = 20
	Local $hImages, $hMain_GUI, $iIndex

	$hMain_GUI = GUICreate("GuiImageList Begin Drag", 225, 400)

	$g_hListView = _GUICtrlListView_Create($hMain_GUI, "Entry Name|Category", 5, 75, 220, 280, -1, BitOR($WS_EX_CLIENTEDGE, $WS_EX_STATICEDGE))
	$g_iLV_Height = 280 - 75
	_GUICtrlListView_SetColumnWidth($g_hListView, 0, 100)
	_GUICtrlListView_SetColumnWidth($g_hListView, 1, 100)
	_GUICtrlListView_SetExtendedListViewStyle($g_hListView, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT, $LVS_EX_CHECKBOXES))
	;------------------------------------------------------
	; Using subitem images
	;------------------------------------------------------
	_GUICtrlListView_SetExtendedListViewStyle($g_hListView, BitOR($LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_SUBITEMIMAGES))

	;------------------------------------------------------
	; create the image list
	;------------------------------------------------------
	$hImages = _GUIImageList_Create($iImage_width, $iImage_height, 5, 1)
	For $x = 1 To 21
		_GUIImageList_AddIcon($hImages, @SystemDir & "\shell32.dll", $x)
	Next

	_GUICtrlListView_SetImageList($g_hListView, $hImages, $LVSIL_SMALL)

	;------------------------------------------------------
	;Register event functions
	;------------------------------------------------------
	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
	GUIRegisterMsg($WM_LBUTTONUP, "WM_LBUTTONUP")
	GUIRegisterMsg($WM_MOUSEMOVE, "WM_MOUSEMOVE")

	;------------------------------------------------------
	; add listview items with images
	;------------------------------------------------------
	Local $y = 1
	For $x = 0 To 9
		$iIndex = _GUICtrlListView_AddItem($g_hListView, "Name " & $x + 1, $y) ; handle, string, image index
		_GUICtrlListView_AddSubItem($g_hListView, $iIndex, "Category " & $x + 1, 1, $y + 1) ; handle, index, string, subitem, image index
		$y += 2
	Next

	GUISetState(@SW_SHOW)

	While 1

		Switch GUIGetMsg()

			;-----------------------------------------------------------------------------------------
			;This case statement exits and updates code if needed
			Case $GUI_EVENT_CLOSE
				ExitLoop
				;-----------------------------------------------------------------------------------------
				;put all the misc. stuff here
			Case Else
				;;;
		EndSwitch
	WEnd

	_GUIImageList_Destroy($hImages)
	GUIDelete()
EndFunc   ;==>Example

#Region Item Function(s) **********************************************************************************************
Func _LVInsertItem($i_FromItem, $i_ToItem)
	Local $iItem_state, $i_NewIndex
	Local $tStruct_LVITEM = DllStructCreate($tagLVITEM)
	Local $tStruct_String = DllStructCreate("wchar Buffer[4096]")

	; Insert item into new position
	DllStructSetData($tStruct_LVITEM, "Mask", BitOR($LVIF_STATE, $LVIF_IMAGE, $LVIF_INDENT, $LVIF_PARAM, $LVIF_TEXT))
	DllStructSetData($tStruct_LVITEM, "StateMask", $LVIS_STATEIMAGEMASK)
	DllStructSetData($tStruct_LVITEM, "Item", $i_FromItem)
	DllStructSetData($tStruct_LVITEM, "SubItem", 0)
	DllStructSetData($tStruct_LVITEM, "TextMax", 4096)
	DllStructSetData($tStruct_LVITEM, "Text", DllStructGetPtr($tStruct_String))
	_GUICtrlListView_GetItemEx($g_hListView, $tStruct_LVITEM)
	If @error Then Return SetError(-1, -1, -1)
	$iItem_state = DllStructGetData($tStruct_LVITEM, "State")
	DllStructSetData($tStruct_LVITEM, "Item", $i_ToItem)
	$i_NewIndex = _GUICtrlListView_InsertItem($g_hListView, DllStructGetData($tStruct_String, "Buffer"), $i_ToItem, DllStructGetData($tStruct_LVITEM, "Image"))
	If @error Then Return SetError(-1, -1, -1)

	; restore previous state
	_DebugPrint("$i_NewIndex = " & $i_NewIndex)
	DllStructSetData($tStruct_LVITEM, "Mask", $LVIF_STATE)
	DllStructSetData($tStruct_LVITEM, "Item", $i_NewIndex)
	DllStructSetData($tStruct_LVITEM, "State", $iItem_state)
	DllStructSetData($tStruct_LVITEM, "StateMask", $LVIS_STATEIMAGEMASK)
	_GUICtrlListView_SetItemState($g_hListView, $i_NewIndex, $iItem_state, $LVIS_STATEIMAGEMASK)
	If @error Then Return SetError(-1, -1, -1)
	Return $i_NewIndex
EndFunc   ;==>_LVInsertItem

; ------------------------------------------------------
Func _LVCopyItem($i_FromItem, $i_ToItem, $i_SubItem = 0)
	Local $tStruct_LVITEM = DllStructCreate($tagLVITEM)
	Local $tStruct_String = DllStructCreate("wchar Buffer[4096]")

	; get from item info
	DllStructSetData($tStruct_LVITEM, "Mask", BitOR($LVIF_STATE, $LVIF_IMAGE, $LVIF_INDENT, $LVIF_PARAM, $LVIF_TEXT))
	DllStructSetData($tStruct_LVITEM, "StateMask", $LVIS_STATEIMAGEMASK)
	DllStructSetData($tStruct_LVITEM, "Item", $i_FromItem)
	DllStructSetData($tStruct_LVITEM, "SubItem", $i_SubItem)
	DllStructSetData($tStruct_LVITEM, "TextMax", 4096)
	DllStructSetData($tStruct_LVITEM, "Text", DllStructGetPtr($tStruct_String))
	_GUICtrlListView_GetItemEx($g_hListView, $tStruct_LVITEM)

	; set to
	DllStructSetData($tStruct_LVITEM, "Item", $i_ToItem)
	; set text
	DllStructSetData($tStruct_LVITEM, "Mask", $LVIF_TEXT)
	DllStructSetData($tStruct_LVITEM, "Text", DllStructGetPtr($tStruct_String))
	DllStructSetData($tStruct_LVITEM, "TextMax", 4096)
	_GUICtrlListView_SetItemEx($g_hListView, $tStruct_LVITEM)
	If @error Then Return SetError(@error, @error, @error)
	; set status
	DllStructSetData($tStruct_LVITEM, "Mask", $LVIF_STATE)
	_GUICtrlListView_SetItemEx($g_hListView, $tStruct_LVITEM)
	; set image
	DllStructSetData($tStruct_LVITEM, "Mask", $LVIF_IMAGE)
	DllStructSetData($tStruct_LVITEM, "State", $LVIF_IMAGE)
	_GUICtrlListView_SetItemEx($g_hListView, $tStruct_LVITEM)
	; set state
	DllStructSetData($tStruct_LVITEM, "Mask", $LVIF_STATE)
	DllStructSetData($tStruct_LVITEM, "State", $LVIF_STATE)
	_GUICtrlListView_SetItemEx($g_hListView, $tStruct_LVITEM)
	; set indent
	DllStructSetData($tStruct_LVITEM, "Mask", $LVIF_INDENT)
	DllStructSetData($tStruct_LVITEM, "State", $LVIF_INDENT)
	_GUICtrlListView_SetItemEx($g_hListView, $tStruct_LVITEM)
	; set Param
	DllStructSetData($tStruct_LVITEM, "Mask", $LVIF_PARAM)
	DllStructSetData($tStruct_LVITEM, "State", $LVIF_PARAM)
	_GUICtrlListView_SetItemEx($g_hListView, $tStruct_LVITEM)
EndFunc   ;==>_LVCopyItem
#EndRegion Item Function(s) **********************************************************************************************

#Region Event Function(s) **********************************************************************************************

; WM_MOUSEMOVE event handler
; ------------------------------------------------------
Func WM_MOUSEMOVE($hWndGUI, $iMsgID, $wParam, $lParam)
	#forceref $iMsgID, $wParam
	;------------------------------------------------------
	; not dragging item we are done here
	;------------------------------------------------------
	If $g_bDragging = False Then Return $GUI_RUNDEFMSG

	;------------------------------------------------------
	; update the image move
	;------------------------------------------------------
	Local $aPos = ControlGetPos($hWndGUI, "", $g_hListView)
	Local $x = BitAND($lParam, 0xFFFF) - $aPos[0]
	Local $y = BitShift($lParam, 16) - $aPos[1]
	If $y > $g_iLV_Height - 20 Then
		_GUICtrlListView_Scroll($g_hListView, 0, $y)
	ElseIf $y < 20 Then
		_GUICtrlListView_Scroll($g_hListView, 0, $y * -1)
	EndIf
	_GUIImageList_DragMove($x, $y)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_MOUSEMOVE

; WM_LBUTTONUP event handler
; ------------------------------------------------------
Func WM_LBUTTONUP($hWndGUI, $iMsgID, $wParam, $lParam)
	#forceref $iMsgID, $wParam
	$g_bDragging = False
	Local $aPos = ControlGetPos($hWndGUI, "", $g_hListView)
	Local $x = BitAND($lParam, 0xFFFF) - $aPos[0]
	Local $y = BitShift($lParam, 16) - $aPos[1]
	_DebugPrint("$x = " & $x)
	_DebugPrint("$y = " & $y)
	;------------------------------------------------------
	; done dragging
	;------------------------------------------------------
	_GUIImageList_DragLeave($g_hListView)
	_GUIImageList_EndDrag()
	_GUIImageList_Destroy($g_ahDragImageList[0])
	_WinAPI_ReleaseCapture()
	;------------------------------------------------------
	; do hit test see if drag ended in the listview
	;------------------------------------------------------
	Local $tStruct_LVHITTESTINFO = DllStructCreate($tagLVHITTESTINFO)

	DllStructSetData($tStruct_LVHITTESTINFO, "X", $x)
	DllStructSetData($tStruct_LVHITTESTINFO, "Y", $y)
	$g_aIndex[1] = _SendMessage($g_hListView, $LVM_HITTEST, 0, DllStructGetPtr($tStruct_LVHITTESTINFO), 0, "wparam", "ptr")
	Local $iFlags = DllStructGetData($tStruct_LVHITTESTINFO, "Flags")
	_DebugPrint("$iFlags: " & $iFlags)
	;------------------------------------------------------
	; // Out of the ListView?
	;------------------------------------------------------
	If $g_aIndex[1] == -1 Then Return $GUI_RUNDEFMSG
	;------------------------------------------------------
	; // Not in an item?
	;------------------------------------------------------
	If BitAND($iFlags, $LVHT_ONITEMLABEL) == 0 And BitAND($iFlags, $LVHT_ONITEMSTATEICON) == 0 And BitAND($iFlags, $LVHT_ONITEMICON) = 0 Then Return $GUI_RUNDEFMSG
	;------------------------------------------------------
	; make sure insert is at least 2 items above or below, don't want to create a duplicate
	;------------------------------------------------------
	If $g_aIndex[0] < $g_aIndex[1] - 1 Or $g_aIndex[0] > $g_aIndex[1] + 1 Then
		_DebugPrint("To = " & $g_aIndex[1])
		Local $i_NewIndex = _LVInsertItem($g_aIndex[0], $g_aIndex[1])
		If @error Then Return SetError(-1, -1, $GUI_RUNDEFMSG)
		Local $iFrom_index = $g_aIndex[0]
		If $g_aIndex[0] > $g_aIndex[1] Then $iFrom_index = $g_aIndex[0] + 1
		;------------------------------------------------------
		; copy item and subitem(s) images, text, and state
		;------------------------------------------------------
		For $x = 1 To _GUICtrlListView_GetColumnCount($g_hListView) - 1
			_LVCopyItem($iFrom_index, $i_NewIndex, $x)
			If @error Then Return SetError(-1, -1, $GUI_RUNDEFMSG)
		Next
		;------------------------------------------------------
		; delete from
		;------------------------------------------------------
		_GUICtrlListView_DeleteItem($g_hListView, $iFrom_index)
	EndIf
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_LBUTTONUP

; WM_NOTIFY event handler
; ------------------------------------------------------
Func WM_NOTIFY($hWndGUI, $iMsgID, $wParam, $lParam)
	#forceref $hWndGUI, $iMsgID, $wParam
	Local $tNMHDR, $iCode, $x, $y, $tNMLISTVIEW, $hWndFrom, $tDraw, $iDrawStage, $iItemSpec
	$tNMHDR = DllStructCreate($tagNMHDR, $lParam) ;NMHDR (hwndFrom, idFrom, code)
	If @error Then Return
	$iCode = DllStructGetData($tNMHDR, "Code")
	$hWndFrom = DllStructGetData($tNMHDR, "hWndFrom")
	Switch $hWndFrom
		Case $g_hListView
			Switch $iCode
				Case $LVN_BEGINDRAG
					_DebugPrint("$LVN_BEGINDRAG")
					$x = BitAND($lParam, 0xFFFF)
					$y = BitShift($lParam, 16)
					$tNMLISTVIEW = DllStructCreate($tagNMLISTVIEW, $lParam)
					$g_aIndex[0] = DllStructGetData($tNMLISTVIEW, "Item")
					$g_ahDragImageList = _GUICtrlListView_CreateDragImage($g_hListView, $g_aIndex[0])
					If @error Then Return SetError(-1, -1, $GUI_RUNDEFMSG)

					_GUIImageList_BeginDrag($g_ahDragImageList[0], 0, 0, 0)

					If @error Then Return SetError(-1, -1, $GUI_RUNDEFMSG)
					_DebugPrint("From = " & $g_aIndex[0])
					_GUIImageList_DragEnter($g_hListView, $x, $y)
					_WinAPI_SetCapture($hWndGUI)
					$g_bDragging = True
				Case $NM_CUSTOMDRAW
					_DebugPrint("$NM_CUSTOMDRAW")
					$tDraw = DllStructCreate($tagNMLVCUSTOMDRAW, $lParam)
					$iDrawStage = DllStructGetData($tDraw, "dwDrawStage")
					$iItemSpec = DllStructGetData($tDraw, "dwItemSpec")
					Switch $iDrawStage
						Case $CDDS_PREPAINT
							_DebugPrint("$CDDS_PREPAINT")
							Return $CDRF_NOTIFYITEMDRAW
						Case $CDDS_ITEMPREPAINT
							_DebugPrint("$CDDS_ITEMPREPAINT")
							If BitAND($iItemSpec, 1) = 1 Then
								DllStructSetData($tDraw, "clrTextBk", $CLR_AQUA)
							Else
								DllStructSetData($tDraw, "clrTextBk", $CLR_WHITE)
							EndIf
							Return $CDRF_NEWFONT
					EndSwitch
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY
#EndRegion Event Function(s) **********************************************************************************************

Func _DebugPrint($s_Text)
	If Not $g_iDebugIt Then Return
	$s_Text = StringReplace($s_Text, @CRLF, @CRLF & "-->")
	ConsoleWrite("!===========================================================" & @CRLF & _
			"+===========================================================" & @CRLF & _
			"-->" & $s_Text & @CRLF & _
			"+===========================================================" & @CRLF)
EndFunc   ;==>_DebugPrint
