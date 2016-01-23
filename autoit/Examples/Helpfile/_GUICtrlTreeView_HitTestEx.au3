#include <GUIConstantsEx.au3>
#include <GuiImageList.au3>
#include <GuiTreeView.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Global $g_hImage, $g_hStateImage

Example()

Func Example()
	Local $ahItem[10], $aidChildItem[30], $iYItem = 0, $iYRand, $iXRand, $idTreeView
	Local $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS)

	GUICreate("TreeView Hit TestEx", 400, 300)

	$idTreeView = GUICtrlCreateTreeView(2, 2, 396, 268, $iStyle, $WS_EX_CLIENTEDGE)
	GUISetState(@SW_SHOW)

	_CreateNormalImageList()
	_GUICtrlTreeView_SetNormalImageList($idTreeView, $g_hImage)

	_CreateStateImageList()
	_GUICtrlTreeView_SetStateImageList($idTreeView, $g_hStateImage)

	_GUICtrlTreeView_BeginUpdate($idTreeView)
	For $x = 0 To 9
		$ahItem[$x] = _GUICtrlTreeView_Add($idTreeView, 0, StringFormat("[%02d] New Item", $x), 4, 5)
		_GUICtrlTreeView_SetStateImageIndex($idTreeView, $ahItem[$x], 1)
		For $y = 1 To 3
			$aidChildItem[$iYItem] = _GUICtrlTreeView_AddChild($idTreeView, $ahItem[$x], StringFormat("[%02d] New Child", $y), 0, 3)
			_GUICtrlTreeView_SetStateImageIndex($idTreeView, $aidChildItem[$iYItem], 1)
			$iYItem += 1
		Next
	Next
	_GUICtrlTreeView_EndUpdate($idTreeView)

	_GUICtrlTreeView_SelectItem($idTreeView, $ahItem[0])
	_GUICtrlTreeView_SetStateImageIndex($idTreeView, $ahItem[0], 2)

	$iYRand = Random(0, 268, 1)
	$iXRand = Random(0, 396, 1)
	MsgBox($MB_SYSTEMMODAL, "Information", StringFormat("Hit TestEx (%d, %d): %s", $iXRand, $iYRand, _GetHitString(_GUICtrlTreeView_HitTestEx($idTreeView, $iXRand, $iYRand))))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

Func _GetHitString($tHitTest)
	Local $iFlags = DllStructGetData($tHitTest, "Flags")
	Select
		Case BitAND($iFlags, $TVHT_NOWHERE) <> 0
			Return "In the client area, but below the last item"
		Case BitAND($iFlags, $TVHT_ONITEMICON) <> 0
			Return "On the bitmap associated with an item"
		Case BitAND($iFlags, $TVHT_ONITEMLABEL) <> 0
			Return "On the text associated with an item"
		Case BitAND($iFlags, $TVHT_ONITEMINDENT) <> 0
			Return "In the indentation associated with an item"
		Case BitAND($iFlags, $TVHT_ONITEMBUTTON) <> 0
			Return "On the button associated with an item"
		Case BitAND($iFlags, $TVHT_ONITEMRIGHT) <> 0
			Return "In the area to the right of an item"
		Case BitAND($iFlags, $TVHT_ONITEMSTATEICON) <> 0
			Return "On the state icon for a item that is in a user-defined state"
		Case BitAND($iFlags, $TVHT_ABOVE) <> 0
			Return "Above the client area"
		Case BitAND($iFlags, $TVHT_BELOW) <> 0
			Return "Below the client area"
		Case BitAND($iFlags, $TVHT_TORIGHT) <> 0
			Return "To the left of the client area"
		Case BitAND($iFlags, $TVHT_TOLEFT) <> 0
			Return "To the right of the client area"
	EndSelect
EndFunc   ;==>_GetHitString

Func _CreateNormalImageList()
	$g_hImage = _GUIImageList_Create(16, 16, 5, 3)
	_GUIImageList_AddIcon($g_hImage, "shell32.dll", 110)
	_GUIImageList_AddIcon($g_hImage, "shell32.dll", 131)
	_GUIImageList_AddIcon($g_hImage, "shell32.dll", 165)
	_GUIImageList_AddIcon($g_hImage, "shell32.dll", 168)
	_GUIImageList_AddIcon($g_hImage, "shell32.dll", 137)
	_GUIImageList_AddIcon($g_hImage, "shell32.dll", 146)
EndFunc   ;==>_CreateNormalImageList

Func _CreateStateImageList()
	$g_hStateImage = _GUIImageList_Create(16, 16, 5, 3)
	_GUIImageList_AddIcon($g_hStateImage, "shell32.dll", 3)
	_GUIImageList_AddIcon($g_hStateImage, "shell32.dll", 4)
EndFunc   ;==>_CreateStateImageList
