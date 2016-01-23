#include <GUIConstantsEx.au3>
#include <GuiImageList.au3>
#include <GuiListView.au3>

Example()

Func Example()
	Local $hImage, $idListview

	; Create GUI
	GUICreate("ListView Add Column", 400, 300)
	$idListview = GUICtrlCreateListView("", 2, 2, 394, 268)

	; Enable extended control styles
	_GUICtrlListView_SetExtendedListViewStyle($idListview, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES))
	GUISetState(@SW_SHOW)

	; Load images
	$hImage = _GUIImageList_Create()
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($idListview), 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($idListview), 0x00FF00, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($idListview), 0x0000FF, 16, 16))
	_GUICtrlListView_SetImageList($idListview, $hImage, 1)

	; Add columns
	_GUICtrlListView_AddColumn($idListview, "Column 1", 110)
	_GUICtrlListView_AddColumn($idListview, "Column 2", 110)
	_GUICtrlListView_AddColumn($idListview, "Column 3", 110)

	; Add items
	_GUICtrlListView_AddItem($idListview, "Row 1: Col 1", 0)
	_GUICtrlListView_AddSubItem($idListview, 0, "Row 1: Col 2", 1, 1)
	_GUICtrlListView_AddSubItem($idListview, 0, "Row 1: Col 3", 2, 2)
	_GUICtrlListView_AddItem($idListview, "Row 2: Col 1", 1)
	_GUICtrlListView_AddSubItem($idListview, 1, "Row 2: Col 2", 1, 2)
	_GUICtrlListView_AddItem($idListview, "Row 3: Col 1", 2)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
