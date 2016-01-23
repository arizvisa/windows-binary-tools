#include <GUIConstantsEx.au3>
#include <GuiImageList.au3>
#include <GuiListView.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $idListview, $hImage
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"
	Local $sAutoItDir = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt", "InstallDir")
	Local $hImage2

	GUICreate("ImageList Duplicate", 410, 300)
	$idListview = GUICtrlCreateListView("", 2, 2, 404, 268, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))
	GUISetState(@SW_SHOW)

	; Create an image list with images
	$hImage = _GUIImageList_Create(11, 11)
	_GUIImageList_AddIcon($hImage, $sAutoItDir & "\Icons\filetype1.ico")
	_GUIImageList_AddIcon($hImage, $sAutoItDir & "\Icons\filetype2.ico")
	_GUIImageList_AddIcon($hImage, $sAutoItDir & "\Icons\filetype3.ico")
	$hImage2 = _GUIImageList_Duplicate($hImage)
	_GUICtrlListView_SetImageList($idListview, $hImage2, 1)

	; Add columns
	_GUICtrlListView_AddColumn($idListview, "Column 1", 100, "Left", 0)
	_GUICtrlListView_AddColumn($idListview, "Column 2", 100, "Left", 1)
	_GUICtrlListView_AddColumn($idListview, "Column 3", 100, "Left", 2)
	_GUICtrlListView_AddColumn($idListview, "Column 4", 100)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
