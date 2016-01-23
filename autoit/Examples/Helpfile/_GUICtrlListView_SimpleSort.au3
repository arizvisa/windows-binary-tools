#include <GUIConstantsEx.au3>
#include <GUIListView.au3>
#include <WindowsConstants.au3>

Global $g_idListView, $g_bSortSense = False ; Set initial ascending sort

Example()

Func Example()
	GUICreate("SimpleSort", 300, 300)
	$g_idListView = GUICtrlCreateListView("Item", 10, 10, 280, 240)
	_GUICtrlListView_SetColumnWidth($g_idListView, 0, 260)
	Local $idButton_Add = GUICtrlCreateButton("Add Item", 10, 260, 80, 30)
	Local $idButton_Set = GUICtrlCreateButton("Reset Ascending Sort Order", 110, 260, 180, 30)

	GUISetState(@SW_SHOW)

	GUIRegisterMsg($WM_NOTIFY, "_WM_NOTIFY")

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $idButton_Add
				Local $sData = Chr(Random(65, 90, 1))
				GUICtrlCreateListViewItem($sData, $g_idListView)
				_GUICtrlListView_SimpleSort($g_idListView, $g_bSortSense, 0, False) ; Prevent sort direction toggling for next insertion
			Case $idButton_Set
				$g_bSortSense = False ; Reset for ascending sort when next sorted
		EndSwitch
	WEnd
EndFunc   ;==>Example

Func _WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam

	Local $hWndListView = $g_idListView
	If Not IsHWnd($g_idListView) Then $hWndListView = GUICtrlGetHandle($g_idListView)
	Local $tNMHDR = DllStructCreate($tagNMLISTVIEW, $lParam)
	Local $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	Local $iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hWndListView
			Switch $iCode
				Case $LVN_COLUMNCLICK ; A column was clicked
					_GUICtrlListView_SimpleSort($hWndListView, $g_bSortSense, DllStructGetData($tNMHDR, "SubItem")) ; Sort direction for next sort toggled by default
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>_WM_NOTIFY
