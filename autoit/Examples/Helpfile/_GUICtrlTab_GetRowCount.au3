#include <GUIConstantsEx.au3>
#include <GuiTab.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $idTab

	; Create GUI
	GUICreate("Tab Control Get Row Count", 400, 300)
	$idTab = GUICtrlCreateTab(2, 2, 396, 296, $TCS_MULTILINE)
	GUISetState(@SW_SHOW)

	; Add tabs
	For $x = 0 To 10
		_GUICtrlTab_InsertItem($idTab, $x, "Tab " & $x + 1)
	Next

	; Get row count
	MsgBox($MB_SYSTEMMODAL, "Information", "Row count: " & _GUICtrlTab_GetRowCount($idTab))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example
