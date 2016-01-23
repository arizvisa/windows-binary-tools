#include <GUIConstantsEx.au3>
#include <GuiImageList.au3>
#include <GuiTab.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $hGUI, $hImage, $idTab

	; Create GUI
	$hGUI = GUICreate("Tab Control Set Padding", 400, 300)
	$idTab = GUICtrlCreateTab(2, 2, 396, 296)
	GUISetState(@SW_SHOW)

	; Create images
	$hImage = _GUIImageList_Create()
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hGUI, 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hGUI, 0x00FF00, 16, 16))
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hGUI, 0x0000FF, 16, 16))
	_GUICtrlTab_SetImageList($idTab, $hImage)

	; Add tabs
	_GUICtrlTab_SetPadding($idTab, 20, 4)
	_GUICtrlTab_InsertItem($idTab, 0, "Tab 1", 0)
	_GUICtrlTab_InsertItem($idTab, 1, "Tab 2", 1)
	_GUICtrlTab_InsertItem($idTab, 2, "Tab 3", 2)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
