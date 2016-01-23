#include <GUIConstantsEx.au3>
#include <GuiImageList.au3>
#include <GuiListView.au3>
#include <WindowsConstants.au3>

Global $g_idListView, $g_idListView2

Example()

Func Example()
	Local $hImage, $aIcons[3] = [0, 3, 6]
	Local $iExWindowStyle = BitOR($WS_EX_DLGMODALFRAME, $WS_EX_CLIENTEDGE)
	Local $iExListViewStyle = BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES, $LVS_EX_GRIDLINES, $LVS_EX_CHECKBOXES, $LVS_EX_DOUBLEBUFFER)

	GUICreate("ListView Sort Treat Numbers as Strings", 300, 200, 100)

	$g_idListView = GUICtrlCreateListView("Column1|Col2|Col3", 10, 10, 280, 180, -1, $iExWindowStyle)
	_GUICtrlListView_SetExtendedListViewStyle($g_idListView, $iExListViewStyle)

	; Load images
	$hImage = _GUIImageList_Create(18, 18, 5, 3)
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", -7)
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", -12)
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", -3)
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", -4)
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", -5)
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", -6)
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", -9)
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", -10)
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", -11)
	_GUICtrlListView_SetImageList($g_idListView, $hImage, 1)

	_AddRow($g_idListView, "ABC|000666|10.05.2004", $aIcons)
	_AddRow($g_idListView, "DEF|444|11.05.2005", $aIcons, 1)
	_AddRow($g_idListView, "CDE|555|12.05.2004", $aIcons, 2)

	GUISetState(@SW_SHOW)

	GUICreate("ListView Sort Treat Numbers as Numbers", 300, 200, 400)

	$g_idListView2 = GUICtrlCreateListView("Column1|Col2|Col3", 10, 10, 280, 180, -1, $iExWindowStyle)
	_GUICtrlListView_SetExtendedListViewStyle($g_idListView2, $iExListViewStyle)
	_GUICtrlListView_SetImageList($g_idListView2, $hImage, 1)

	_AddRow($g_idListView2, "ABC|000666|10.05.2004", $aIcons)
	_AddRow($g_idListView2, "DEF|444|11.05.2005", $aIcons, 1)
	_AddRow($g_idListView2, "CDE|555|12.05.2004", $aIcons, 2)

	GUISetState(@SW_SHOW)

	_GUICtrlListView_RegisterSortCallBack($g_idListView, False)
	_GUICtrlListView_RegisterSortCallBack($g_idListView2)
	GUIRegisterMsg($WM_NOTIFY, "_WM_NOTIFY")

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	_GUICtrlListView_UnRegisterSortCallBack($g_idListView)
	_GUICtrlListView_UnRegisterSortCallBack($g_idListView2)
	GUIRegisterMsg($WM_NOTIFY, "")
EndFunc   ;==>Example

Func _AddRow($hWnd, $sItem, $aIcons, $iPlus = 0)
	Local $aItem = StringSplit($sItem, "|")
	Local $iIndex = _GUICtrlListView_AddItem($hWnd, $aItem[1], $aIcons[0] + $iPlus, _GUICtrlListView_GetItemCount($hWnd) + 9999)
	_GUICtrlListView_SetColumnWidth($hWnd, 0, $LVSCW_AUTOSIZE_USEHEADER)

	For $x = 2 To $aItem[0]
		_GUICtrlListView_AddSubItem($hWnd, $iIndex, $aItem[$x], $x - 1, $aIcons[$x - 1] + $iPlus)
		_GUICtrlListView_SetColumnWidth($hWnd, $x - 1, $LVSCW_AUTOSIZE)
	Next
EndFunc   ;==>_AddRow

Func _WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam
	Local $hWndFrom, $iCode, $tNMHDR, $hWndListView, $hWndListView2

	$hWndListView = $g_idListView
	$hWndListView2 = $g_idListView2
	If Not IsHWnd($g_idListView) Then $hWndListView = GUICtrlGetHandle($g_idListView)
	If Not IsHWnd($g_idListView2) Then $hWndListView2 = GUICtrlGetHandle($g_idListView2)

	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iCode = DllStructGetData($tNMHDR, "Code")

	Switch $hWndFrom
		Case $hWndListView, $hWndListView2
			Switch $iCode
				Case $LVN_COLUMNCLICK ; A column was clicked
					Local $tInfo = DllStructCreate($tagNMLISTVIEW, $lParam)

					; Kick off the sort callback
					_GUICtrlListView_SortItems($hWndFrom, DllStructGetData($tInfo, "SubItem"))
					; No return value
			EndSwitch
	EndSwitch
	Return $__LISTVIEWCONSTANT_GUI_RUNDEFMSG
EndFunc   ;==>_WM_NOTIFY
