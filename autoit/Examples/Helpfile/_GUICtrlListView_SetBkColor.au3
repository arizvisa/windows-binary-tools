#include <ColorConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idListview

	GUICreate("ListView Set BkColor", 400, 300)
	$idListview = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	; Set colors
	_GUICtrlListView_SetBkColor($idListview, $CLR_MONEYGREEN)
	_GUICtrlListView_SetTextColor($idListview, $CLR_BLACK)
	_GUICtrlListView_SetTextBkColor($idListview, $CLR_MONEYGREEN)

	; Add columns
	_GUICtrlListView_AddColumn($idListview, "Items", 100)

	; Add items
	_GUICtrlListView_BeginUpdate($idListview)
	For $iI = 1 To 10
		_GUICtrlListView_AddItem($idListview, "Item " & $iI)
	Next
	_GUICtrlListView_EndUpdate($idListview)

	; Show colors
	MsgBox($MB_SYSTEMMODAL, "Information", "Back Color ....: " & _GUICtrlListView_GetBkColor($idListview) & @CRLF & _
			"Text Color ....: " & _GUICtrlListView_GetTextColor($idListview) & @CRLF & _
			"Text Back Color: " & _GUICtrlListView_GetTextBkColor($idListview))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
