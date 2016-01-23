#include <GUIConstantsEx.au3>
#include <GuiHeader.au3>
#include <GuiImageList.au3>
#include <WinAPI.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hGUI, $hHeader, $hImage, $tItem

	; Create GUI
	$hGUI = GUICreate("Header", 400, 300)
	$hHeader = _GUICtrlHeader_Create($hGUI)
	_GUICtrlHeader_SetUnicodeFormat($hHeader, True)
	$g_idMemo = GUICtrlCreateEdit("", 2, 24, 396, 274, 0)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Create an image list with images
	$hImage = _GUIImageList_Create(11, 11)
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hGUI, 0xFF0000, 11, 11))
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hGUI, 0x00FF00, 11, 11))
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($hGUI, 0x0000FF, 11, 11))
	_GUICtrlHeader_SetImageList($hHeader, $hImage)

	; Add columns
	_GUICtrlHeader_AddItem($hHeader, "Column 1", 100, 0, 0)
	_GUICtrlHeader_AddItem($hHeader, "Column 2", 100, 0, 1)
	_GUICtrlHeader_AddItem($hHeader, "Column 3", 100, 0, 2)
	_GUICtrlHeader_AddItem($hHeader, "Column 4", 100)

	; Set column 3 image index
	$tItem = DllStructCreate($tagHDITEM)
	DllStructSetData($tItem, "Mask", $HDI_IMAGE)
	DllStructSetData($tItem, "Image", 0)
	_GUICtrlHeader_SetItem($hHeader, 2, $tItem)

	; Show column 3 image index
	$tItem = DllStructCreate($tagHDITEM)
	DllStructSetData($tItem, "Mask", $HDI_IMAGE)
	_GUICtrlHeader_GetItem($hHeader, 2, $tItem)
	MemoWrite("Column 3 image index: " & DllStructGetData($tItem, "Image"))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Write a line to the memo control
Func MemoWrite($sMessage)
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
