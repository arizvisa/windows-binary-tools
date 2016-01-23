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

	GUICreate("ImageList Copy", 410, 300)
	$idListview = GUICtrlCreateListView("", 2, 2, 404, 268, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))
	GUISetState(@SW_SHOW)

	; Create an image list with images
	$hImage = _GUIImageList_Create(11, 11)
	ConsoleWrite(_GUIImageList_AddIcon($hImage, $sAutoItDir & "\Icons\filetype1.ico") & @CRLF)
	ConsoleWrite(_GUIImageList_AddIcon($hImage, $sAutoItDir & "\Icons\filetype2.ico") & @CRLF)
	ConsoleWrite(_GUIImageList_AddIcon($hImage, $sAutoItDir & "\Icons\filetype3.ico") & @CRLF)
	ConsoleWrite(_GUIImageList_AddIcon($hImage, $sAutoItDir & "\Icons\filetype3.ico") & @CRLF)
	_GUIImageList_Copy($hImage, 0, 3)
	_GUICtrlListView_SetImageList($idListview, $hImage, 1)

	; Add columns
	_GUICtrlListView_AddColumn($idListview, "Column 1", 100, 1, 0, True)
	_GUICtrlListView_AddColumn($idListview, "Column 2", 100, 0, 1, True)
	_GUICtrlListView_AddColumn($idListview, "Column 3", 100, 2, 2, True)
	_GUICtrlListView_AddColumn($idListview, "Column 4", 100, 0, 3)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
