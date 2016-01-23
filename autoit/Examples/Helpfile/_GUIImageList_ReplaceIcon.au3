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

	GUICreate("ImageList AddIcon", 410, 300)
	$idListview = GUICtrlCreateListView("", 2, 2, 404, 268, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT))
	GUISetState(@SW_SHOW)

	; Create an image list with images
	$hImage = _GUIImageList_Create(11, 11)
	AddIcon($hImage, $sAutoItDir & "\Icons\au3.ico")
	AddIcon($hImage, $sAutoItDir & "\Icons\au3script_v9.ico")
	AddIcon($hImage, $sAutoItDir & "\Icons\au3script_v10.ico")
	_GUICtrlListView_SetImageList($idListview, $hImage, 1)

	; Add columns
	_GUICtrlListView_AddColumn($idListview, "Column 1", 100, 0, 0)
	_GUICtrlListView_AddColumn($idListview, "Column 2", 100, 1, 1)
	_GUICtrlListView_AddColumn($idListview, "Column 3", 100, 2, 2)
	_GUICtrlListView_AddColumn($idListview, "Column 4", 100)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

; This is the long way to add an icon. Use _GUIImageList_AddIcon instead
Func AddIcon($hWnd, $sFile, $iIndex = 0)
	Local $tIcon, $hIcon

	$tIcon = DllStructCreate("int Icon")
	_WinAPI_ExtractIconEx($sFile, $iIndex, 0, $tIcon, 1)
	$hIcon = DllStructGetData($tIcon, "Icon")
	_GUIImageList_ReplaceIcon($hWnd, -1, $hIcon)
	_WinAPI_DestroyIcon($hIcon)
EndFunc   ;==>AddIcon
