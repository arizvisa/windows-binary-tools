#include <GUIConstantsEx.au3>
#include <GuiImageList.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hImage, $idListview

	; Create GUI
	GUICreate("ListView Set Icon Spacing", 400, 300)
	$idListview = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUICtrlSetStyle($idListview, $LVS_ICON)
	GUISetState(@SW_SHOW)

	; Load images
	$hImage = _GUIImageList_Create()
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($idListview, 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($idListview, 0x00FF00, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($idListview, 0x0000FF, 16, 16))
	_GUICtrlListView_SetImageList($idListview, $hImage, 0)

	; Add items
	_GUICtrlListView_AddItem($idListview, "Item 1", 0)
	_GUICtrlListView_AddItem($idListview, "Item 2", 1)
	_GUICtrlListView_AddItem($idListview, "Item 3", 2)

	; Change item spacing
	MsgBox($MB_SYSTEMMODAL, "Information", "Changing icon spacing")
	_GUICtrlListView_SetIconSpacing($idListview, 32, 32)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
