#include <GUIConstantsEx.au3>
#include <GuiImageList.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hImage, $idListview

	GUICreate("ListView Get Extended List View Style", 400, 300)
	$idListview = GUICtrlCreateListView("", 2, 2, 394, 268)
	_GUICtrlListView_SetExtendedListViewStyle($idListview, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_GRIDLINES, $LVS_EX_SUBITEMIMAGES))
	GUISetState(@SW_SHOW)

	; Load images
	$hImage = _GUIImageList_Create()
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($idListview), 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($idListview), 0x00FF00, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($idListview), 0x0000FF, 16, 16))
	_GUICtrlListView_SetImageList($idListview, $hImage, 1)

	; Add columns
	_GUICtrlListView_AddColumn($idListview, "Column 1", 100)
	_GUICtrlListView_AddColumn($idListview, "Column 2", 100)
	_GUICtrlListView_AddColumn($idListview, "Column 3", 100)

	_GUICtrlListView_InsertItem($idListview, "Row 1: Col 1", -1, 0)
	_GUICtrlListView_AddSubItem($idListview, 0, "Row 1: Col 2", 1, 1)
	_GUICtrlListView_AddSubItem($idListview, 0, "Row 1: Col 3", 2, 2)
	_GUICtrlListView_InsertItem($idListview, "Row 2: Col 1", -1, 1)
	_GUICtrlListView_AddSubItem($idListview, 1, "Row 2: Col 2", 1, 2)
	_GUICtrlListView_InsertItem($idListview, "Row 3: Col 1", -1, 2)

	MsgBox($MB_SYSTEMMODAL, "Information", "Extended List View Style(s): 0x" & _GUICtrlListView_GetExtendedListViewStyle($idListview) & @CRLF & _
			_DisplayExtendStringList($idListview))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

Func _DisplayExtendStringList($idListview)
	Local $sStyles = @CRLF & @CRLF & @TAB
	If (BitAND(_GUICtrlListView_GetExtendedListViewStyle($idListview), $LVS_EX_BORDERSELECT) = $LVS_EX_BORDERSELECT) Then $sStyles &= "$LVS_EX_BORDERSELECT" & @CRLF & @TAB
	If (BitAND(_GUICtrlListView_GetExtendedListViewStyle($idListview), $LVS_EX_CHECKBOXES) = $LVS_EX_CHECKBOXES) Then $sStyles &= "$LVS_EX_CHECKBOXES" & @CRLF & @TAB
	If (BitAND(_GUICtrlListView_GetExtendedListViewStyle($idListview), $LVS_EX_DOUBLEBUFFER) = $LVS_EX_DOUBLEBUFFER) Then $sStyles &= "$LVS_EX_DOUBLEBUFFER" & @CRLF & @TAB
	If (BitAND(_GUICtrlListView_GetExtendedListViewStyle($idListview), $LVS_EX_FLATSB) = $LVS_EX_FLATSB) Then $sStyles &= "$LVS_EX_FLATSB" & @CRLF & @TAB
	If (BitAND(_GUICtrlListView_GetExtendedListViewStyle($idListview), $LVS_EX_FULLROWSELECT) = $LVS_EX_FULLROWSELECT) Then $sStyles &= "$LVS_EX_FULLROWSELECT" & @CRLF & @TAB
	If (BitAND(_GUICtrlListView_GetExtendedListViewStyle($idListview), $LVS_EX_GRIDLINES) = $LVS_EX_GRIDLINES) Then $sStyles &= "$LVS_EX_GRIDLINES" & @CRLF & @TAB
	If (BitAND(_GUICtrlListView_GetExtendedListViewStyle($idListview), $LVS_EX_HEADERDRAGDROP) = $LVS_EX_HEADERDRAGDROP) Then $sStyles &= "$LVS_EX_HEADERDRAGDROP" & @CRLF & @TAB
	If (BitAND(_GUICtrlListView_GetExtendedListViewStyle($idListview), $LVS_EX_INFOTIP) = $LVS_EX_INFOTIP) Then $sStyles &= "$LVS_EX_INFOTIP" & @CRLF & @TAB
	If (BitAND(_GUICtrlListView_GetExtendedListViewStyle($idListview), $LVS_EX_LABELTIP) = $LVS_EX_LABELTIP) Then $sStyles &= "$LVS_EX_LABELTIP" & @CRLF & @TAB
	If (BitAND(_GUICtrlListView_GetExtendedListViewStyle($idListview), $LVS_EX_MULTIWORKAREAS) = $LVS_EX_MULTIWORKAREAS) Then $sStyles &= "$LVS_EX_MULTIWORKAREAS" & @CRLF & @TAB
	If (BitAND(_GUICtrlListView_GetExtendedListViewStyle($idListview), $LVS_EX_ONECLICKACTIVATE) = $LVS_EX_ONECLICKACTIVATE) Then $sStyles &= "$LVS_EX_ONECLICKACTIVATE" & @CRLF & @TAB
	If (BitAND(_GUICtrlListView_GetExtendedListViewStyle($idListview), $LVS_EX_REGIONAL) = $LVS_EX_REGIONAL) Then $sStyles &= "$LVS_EX_REGIONAL" & @CRLF & @TAB
	If (BitAND(_GUICtrlListView_GetExtendedListViewStyle($idListview), $LVS_EX_SIMPLESELECT) = $LVS_EX_SIMPLESELECT) Then $sStyles &= "$LVS_EX_SIMPLESELECT" & @CRLF & @TAB
	If (BitAND(_GUICtrlListView_GetExtendedListViewStyle($idListview), $LVS_EX_SUBITEMIMAGES) = $LVS_EX_SUBITEMIMAGES) Then $sStyles &= "$LVS_EX_SUBITEMIMAGES" & @CRLF & @TAB
	If (BitAND(_GUICtrlListView_GetExtendedListViewStyle($idListview), $LVS_EX_TRACKSELECT) = $LVS_EX_TRACKSELECT) Then $sStyles &= "$LVS_EX_TRACKSELECT" & @CRLF & @TAB
	If (BitAND(_GUICtrlListView_GetExtendedListViewStyle($idListview), $LVS_EX_TWOCLICKACTIVATE) = $LVS_EX_TWOCLICKACTIVATE) Then $sStyles &= "$LVS_EX_TWOCLICKACTIVATE" & @CRLF & @TAB
	If (BitAND(_GUICtrlListView_GetExtendedListViewStyle($idListview), $LVS_EX_UNDERLINECOLD) = $LVS_EX_UNDERLINECOLD) Then $sStyles &= "$LVS_EX_UNDERLINECOLD" & @CRLF & @TAB
	If (BitAND(_GUICtrlListView_GetExtendedListViewStyle($idListview), $LVS_EX_UNDERLINEHOT) = $LVS_EX_UNDERLINEHOT) Then $sStyles &= "$LVS_EX_UNDERLINEHOT" & @CRLF & @TAB
	Return $sStyles
EndFunc   ;==>_DisplayExtendStringList
