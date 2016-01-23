#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $iI, $iTimer, $idListview

	; Create GUI
	GUICreate("ListView Add Array", 400, 300)
	$idListview = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState(@SW_SHOW)

	; Add columns
	_GUICtrlListView_AddColumn($idListview, "Items", 100)
	_GUICtrlListView_AddColumn($idListview, "SubItems 1", 100)
	_GUICtrlListView_AddColumn($idListview, "SubItems 2", 100)
	_GUICtrlListView_AddColumn($idListview, "SubItems 3", 100)

	_GUICtrlListView_SetItemCount($idListview, 5000)

	; One column load
	Local $aItems[5000][1]
	For $iI = 0 To UBound($aItems) - 1
		$aItems[$iI][0] = "Item " & $iI
	Next
	$iTimer = TimerInit()
	_GUICtrlListView_AddArray($idListview, $aItems)
	MsgBox($MB_SYSTEMMODAL, "Information", "Load time: " & TimerDiff($iTimer) / 1000 & " seconds")

	_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($idListview)) ; items added with UDF function can be deleted using UDF function

	; Four column load
	Local $aItems[5000][4]
	For $iI = 0 To UBound($aItems) - 1
		$aItems[$iI][0] = "Item " & $iI
		$aItems[$iI][1] = "Item " & $iI & "-1"
		$aItems[$iI][2] = "Item " & $iI & "-2"
		$aItems[$iI][3] = "Item " & $iI & "-3"
	Next
	$iTimer = TimerInit()
	_GUICtrlListView_AddArray($idListview, $aItems)
	MsgBox($MB_SYSTEMMODAL, "Information", "Load time: " & TimerDiff($iTimer) / 1000 & " seconds")

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
