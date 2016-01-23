#include <GUIConstantsEx.au3>
#include <GuiImageList.au3>
#include <GuiListView.au3>
#include <WindowsConstants.au3>

Global $g_idListView

Example()

Func Example()
	Local $hImage, $aIcons[3] = [0, 3, 6]
	Local $iExWindowStyle = BitOR($WS_EX_DLGMODALFRAME, $WS_EX_CLIENTEDGE)
	Local $iExListViewStyle = BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES, $LVS_EX_GRIDLINES, $LVS_EX_CHECKBOXES, $LVS_EX_DOUBLEBUFFER)

	GUICreate("ListView Sort", 300, 200)

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

	_GUICtrlListView_RegisterSortCallBack($g_idListView)

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $g_idListView
				; Kick off the sort callback
				_GUICtrlListView_SortItems($g_idListView, GUICtrlGetState($g_idListView))
		EndSwitch
	WEnd

	_GUICtrlListView_UnRegisterSortCallBack($g_idListView)
	GUIDelete()
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
