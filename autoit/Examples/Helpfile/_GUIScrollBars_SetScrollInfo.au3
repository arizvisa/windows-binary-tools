#include <GUIConstantsEx.au3>
#include <GuiScrollBars.au3>
#include <StructureConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $idFileMenu, $idExititem, $hGUIMsg, $hGUI, $h_GUIC, $h_GUIC2
	Local $idListview, $idButton

	$hGUI = GUICreate("ScrollBar Example", 400, 400, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU, $WS_SIZEBOX))
	GUISetBkColor(0x88AABB)

	$idFileMenu = GUICtrlCreateMenu("File")
	$idExititem = GUICtrlCreateMenuItem("Exit", $idFileMenu)
	$idListview = GUICtrlCreateListView("col1  |col2|col3  ", 10, 10, 200, 150) ; ,$LVS_SORTDESCENDING)
	$idButton = GUICtrlCreateButton("Value?", 75, 170, 70, 20)
	GUICtrlSetResizing($idButton, $GUI_DOCKALL)
	For $x = 1 To 30
		GUICtrlCreateListViewItem("item" & $x & "|col2|col3", $idListview)
	Next
	GUICtrlSetResizing($idListview, $GUI_DOCKALL)

	$h_GUIC = GUICreate("Child GUI", 200, 200, 10, 200, $WS_CHILD, $WS_EX_CLIENTEDGE, $hGUI)
	GUICtrlCreateButton("a button", 10, 10, 90, 20)
	GUISetBkColor(0X006400)
	GUISetState(@SW_SHOW)
	GUICtrlSetResizing($h_GUIC, $GUI_DOCKALL)

	GUISwitch($hGUI)

	$h_GUIC2 = GUICreate("Child GUI", 200, 200, 215, 10, $WS_CHILD, $WS_EX_CLIENTEDGE, $hGUI)
	GUICtrlCreateButton("a button", 10, 10, 90, 20)
	GUISetBkColor(0X006400)
	GUISetState(@SW_SHOW)
	GUICtrlSetResizing($h_GUIC2, $GUI_DOCKALL)

	GUISwitch($hGUI)

	GUIRegisterMsg($WM_SIZE, "WM_SIZE")
	GUIRegisterMsg($WM_VSCROLL, "WM_VSCROLL")
	GUIRegisterMsg($WM_HSCROLL, "WM_HSCROLL")

	GUISetState(@SW_SHOW)

	_GUIScrollBars_Init($hGUI)
	_GUIScrollBars_Init($h_GUIC)

	While 1
		$hGUIMsg = GUIGetMsg()

		Switch $hGUIMsg
			Case $GUI_EVENT_CLOSE, $idExititem
				ExitLoop
		EndSwitch
	WEnd

	Exit
EndFunc   ;==>Example

Func WM_SIZE($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	Local $iIndex = -1, $iCharY, $iCharX, $iClientMaxX, $iClientX, $iClientY, $iMax
	For $x = 0 To UBound($__g_aSB_WindowInfo) - 1
		If $__g_aSB_WindowInfo[$x][0] = $hWnd Then
			$iIndex = $x
			$iClientMaxX = $__g_aSB_WindowInfo[$iIndex][1]
			$iCharX = $__g_aSB_WindowInfo[$iIndex][2]
			$iCharY = $__g_aSB_WindowInfo[$iIndex][3]
			$iMax = $__g_aSB_WindowInfo[$iIndex][7]
			ExitLoop
		EndIf
	Next
	If $iIndex = -1 Then Return 0

	Local $tSCROLLINFO = DllStructCreate($tagSCROLLINFO)

	; Retrieve the dimensions of the client area.
	$iClientX = BitAND($lParam, 0x0000FFFF)
	$iClientY = BitShift($lParam, 16)
	$__g_aSB_WindowInfo[$iIndex][4] = $iClientX
	$__g_aSB_WindowInfo[$iIndex][5] = $iClientY

	; Set the vertical scrolling range and page size
	DllStructSetData($tSCROLLINFO, "fMask", BitOR($SIF_RANGE, $SIF_PAGE))
	DllStructSetData($tSCROLLINFO, "nMin", 0)
	DllStructSetData($tSCROLLINFO, "nMax", $iMax)
	DllStructSetData($tSCROLLINFO, "nPage", $iClientY / $iCharY)
	_GUIScrollBars_SetScrollInfo($hWnd, $SB_VERT, $tSCROLLINFO)

	; Set the horizontal scrolling range and page size
	DllStructSetData($tSCROLLINFO, "fMask", BitOR($SIF_RANGE, $SIF_PAGE))
	DllStructSetData($tSCROLLINFO, "nMin", 0)
	DllStructSetData($tSCROLLINFO, "nMax", 2 + $iClientMaxX / $iCharX)
	DllStructSetData($tSCROLLINFO, "nPage", $iClientX / $iCharX)
	_GUIScrollBars_SetScrollInfo($hWnd, $SB_HORZ, $tSCROLLINFO)

	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SIZE

Func WM_HSCROLL($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $lParam
	Local $iScrollCode = BitAND($wParam, 0x0000FFFF)

	Local $iIndex = -1, $iCharX, $iPosX
	Local $iMin, $iMax, $iPage, $iPos, $iTrackPos

	For $x = 0 To UBound($__g_aSB_WindowInfo) - 1
		If $__g_aSB_WindowInfo[$x][0] = $hWnd Then
			$iIndex = $x
			$iCharX = $__g_aSB_WindowInfo[$iIndex][2]
			ExitLoop
		EndIf
	Next
	If $iIndex = -1 Then Return 0

	; ; Get all the horizontal scroll bar information
	Local $tSCROLLINFO = _GUIScrollBars_GetScrollInfoEx($hWnd, $SB_HORZ)
	$iMin = DllStructGetData($tSCROLLINFO, "nMin")
	$iMax = DllStructGetData($tSCROLLINFO, "nMax")
	$iPage = DllStructGetData($tSCROLLINFO, "nPage")
	; Save the position for comparison later on
	$iPosX = DllStructGetData($tSCROLLINFO, "nPos")
	$iPos = $iPosX
	$iTrackPos = DllStructGetData($tSCROLLINFO, "nTrackPos")
	#forceref $iMin, $iMax
	Switch $iScrollCode

		Case $SB_LINELEFT ; user clicked left arrow
			DllStructSetData($tSCROLLINFO, "nPos", $iPos - 1)

		Case $SB_LINERIGHT ; user clicked right arrow
			DllStructSetData($tSCROLLINFO, "nPos", $iPos + 1)

		Case $SB_PAGELEFT ; user clicked the scroll bar shaft left of the scroll box
			DllStructSetData($tSCROLLINFO, "nPos", $iPos - $iPage)

		Case $SB_PAGERIGHT ; user clicked the scroll bar shaft right of the scroll box
			DllStructSetData($tSCROLLINFO, "nPos", $iPos + $iPage)

		Case $SB_THUMBTRACK ; user dragged the scroll box
			DllStructSetData($tSCROLLINFO, "nPos", $iTrackPos)
	EndSwitch

	; // Set the position and then retrieve it.  Due to adjustments
	; //   by Windows it may not be the same as the value set.

	DllStructSetData($tSCROLLINFO, "fMask", $SIF_POS)
	_GUIScrollBars_SetScrollInfo($hWnd, $SB_HORZ, $tSCROLLINFO)
	_GUIScrollBars_GetScrollInfo($hWnd, $SB_HORZ, $tSCROLLINFO)
	;// If the position has changed, scroll the window and update it
	$iPos = DllStructGetData($tSCROLLINFO, "nPos")
	If ($iPos <> $iPosX) Then _GUIScrollBars_ScrollWindow($hWnd, $iCharX * ($iPosX - $iPos), 0)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_HSCROLL

Func WM_VSCROLL($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam, $lParam
	Local $iScrollCode = BitAND($wParam, 0x0000FFFF)
	Local $iIndex = -1, $iCharY, $iPosY
	Local $iMin, $iMax, $iPage, $iPos, $iTrackPos

	For $x = 0 To UBound($__g_aSB_WindowInfo) - 1
		If $__g_aSB_WindowInfo[$x][0] = $hWnd Then
			$iIndex = $x
			$iCharY = $__g_aSB_WindowInfo[$iIndex][3]
			ExitLoop
		EndIf
	Next
	If $iIndex = -1 Then Return 0

	; Get all the vertial scroll bar information
	Local $tSCROLLINFO = _GUIScrollBars_GetScrollInfoEx($hWnd, $SB_VERT)
	$iMin = DllStructGetData($tSCROLLINFO, "nMin")
	$iMax = DllStructGetData($tSCROLLINFO, "nMax")
	$iPage = DllStructGetData($tSCROLLINFO, "nPage")
	; Save the position for comparison later on
	$iPosY = DllStructGetData($tSCROLLINFO, "nPos")
	$iPos = $iPosY
	$iTrackPos = DllStructGetData($tSCROLLINFO, "nTrackPos")

	Switch $iScrollCode
		Case $SB_TOP ; user clicked the HOME keyboard key
			DllStructSetData($tSCROLLINFO, "nPos", $iMin)

		Case $SB_BOTTOM ; user clicked the END keyboard key
			DllStructSetData($tSCROLLINFO, "nPos", $iMax)

		Case $SB_LINEUP ; user clicked the top arrow
			DllStructSetData($tSCROLLINFO, "nPos", $iPos - 1)

		Case $SB_LINEDOWN ; user clicked the bottom arrow
			DllStructSetData($tSCROLLINFO, "nPos", $iPos + 1)

		Case $SB_PAGEUP ; user clicked the scroll bar shaft above the scroll box
			DllStructSetData($tSCROLLINFO, "nPos", $iPos - $iPage)

		Case $SB_PAGEDOWN ; user clicked the scroll bar shaft below the scroll box
			DllStructSetData($tSCROLLINFO, "nPos", $iPos + $iPage)

		Case $SB_THUMBTRACK ; user dragged the scroll box
			DllStructSetData($tSCROLLINFO, "nPos", $iTrackPos)
	EndSwitch

	; // Set the position and then retrieve it.  Due to adjustments
	; //   by Windows it may not be the same as the value set.

	DllStructSetData($tSCROLLINFO, "fMask", $SIF_POS)
	_GUIScrollBars_SetScrollInfo($hWnd, $SB_VERT, $tSCROLLINFO)
	_GUIScrollBars_GetScrollInfo($hWnd, $SB_VERT, $tSCROLLINFO)
	;// If the position has changed, scroll the window and update it
	$iPos = DllStructGetData($tSCROLLINFO, "nPos")

	If ($iPos <> $iPosY) Then
		_GUIScrollBars_ScrollWindow($hWnd, 0, $iCharY * ($iPosY - $iPos))
		$iPosY = $iPos
	EndIf

	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_VSCROLL
