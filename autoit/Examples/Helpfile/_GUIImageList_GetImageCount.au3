#include <GUIConstantsEx.au3>
#include <GuiImageList.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $idListview, $hImage, $iRandom
	Local $iStylesEx = BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES)

	GUICreate("ImageList Get Image Count", 400, 300)
	$idListview = GUICtrlCreateListView("", 2, 2, 394, 268, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))
	_GUICtrlListView_SetExtendedListViewStyle($idListview, $iStylesEx)
	GUISetState(@SW_SHOW)

	; Load images
	$hImage = _GUIImageList_Create(16, 16, 5, 3)
	$iRandom = Random(6, 20, 1)
	For $x = 1 To $iRandom
		_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", $x)
	Next
	_GUICtrlListView_SetImageList($idListview, $hImage, 1)

	; Add columns
	_GUICtrlListView_AddColumn($idListview, "Column 1", 120)
	_GUICtrlListView_AddColumn($idListview, "Column 2", 100)
	_GUICtrlListView_AddColumn($idListview, "Column 3", 100)

	; Add items
	_GUICtrlListView_AddItem($idListview, "Row 1: Col 1", 0)
	_GUICtrlListView_AddSubItem($idListview, 0, "Row 1: Col 2", 1, 1)
	_GUICtrlListView_AddSubItem($idListview, 0, "Row 1: Col 3", 2, 2)
	_GUICtrlListView_AddItem($idListview, "Row 2: Col 1", 1)
	_GUICtrlListView_AddSubItem($idListview, 1, "Row 2: Col 2", 1, 2)
	_GUICtrlListView_AddItem($idListview, "Row 3: Col 1", 2)
	_GUICtrlListView_AddItem($idListview, "Row 4: Col 1", 3)
	_GUICtrlListView_AddItem($idListview, "Row 5: Col 1", 4)
	_GUICtrlListView_AddSubItem($idListview, 4, "Row 5: Col 2", 1, 3)
	_GUICtrlListView_AddItem($idListview, "Row 6: Col 1", 5)
	_GUICtrlListView_AddSubItem($idListview, 5, "Row 6: Col 2", 1, 4)
	_GUICtrlListView_AddSubItem($idListview, 5, "Row 6: Col 3", 2, 3)

	MsgBox($MB_SYSTEMMODAL, "Information", "Image Count: " & _GUIImageList_GetImageCount($hImage))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
