; Create an ownerdrawn/colored button

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local Const $BS_OWNERDRAW = 0x0000000B

	GUICreate("My Ownerdrawn Created Button", 300, 200)

	Local $idButton = GUICtrlCreateButton("", 90, 50, 120, 30)
	GUICtrlSetStyle($idButton, BitOR($WS_TABSTOP, $BS_NOTIFY, $BS_OWNERDRAW)) ; Set the ownerdrawn flag

	Local $idButton2 = GUICtrlCreateButton("Normal Button", 90, 110, 120, 30)

	GUIRegisterMsg($WM_COMMAND, "MY_WM_COMMAND")
	; WM_DRAWITEM has to registered before showing GUI otherwise the initial drawing isn't done
	GUIRegisterMsg($WM_DRAWITEM, "MY_WM_DRAWITEM")

	GUISetState(@SW_SHOW)

	Local $iMsg
	While 1
		$iMsg = GUIGetMsg()

		Switch $iMsg
			Case $GUI_EVENT_CLOSE
				ExitLoop

			Case $idButton
				; Normally should not run through cause of our MY_WM_COMMAND function
				MsgBox($MB_SYSTEMMODAL, "Info", "Button pressed")

			Case $idButton2
				; Normally should not run through cause of our MY_WM_COMMAND function
				MsgBox($MB_SYSTEMMODAL, "Info", "Button2 pressed")
		EndSwitch
	WEnd

	GUIDelete()
EndFunc   ;==>Example

; React on a button click
Func MY_WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
	Local $nNotifyCode = BitShift($wParam, 16)
	Local $nID = BitAND($wParam, 0x0000FFFF)
	Local $hCtrl = $lParam

	If $nID <> 2 And $nNotifyCode = 0 Then ; Check for IDCANCEL - 2
		; Ownerdrawn buttons don't send something by pressing ENTER
		; So IDOK - 1 comes up, now check for the control that has the current focus
		If $nID = 1 Then
			Local $hFocus = DllCall("user32.dll", "hwnd", "GetFocus")
			Local $nCtrlID = DllCall("user32.dll", "int", "GetDlgCtrlID", "hwnd", $hFocus[0])
			PostButtonClick($hWnd, $nCtrlID[0])
		Else
			MsgBox($MB_SYSTEMMODAL, "MY_WM_COMMAND", "GUIHWnd" & @TAB & ":" & $hWnd & @CRLF & _
					"MsgID" & @TAB & ":" & $iMsg & @CRLF & _
					"wParam" & @TAB & ":" & $wParam & @CRLF & _
					"lParam" & @TAB & ":" & $lParam & @CRLF & @CRLF & _
					"WM_COMMAND - Infos:" & @CRLF & _
					"-----------------------------" & @CRLF & _
					"Code" & @TAB & ":" & $nNotifyCode & @CRLF & _
					"CtrlID" & @TAB & ":" & $nID & @CRLF & _
					"CtrlHWnd" & @TAB & ":" & $hCtrl)
		EndIf
		Return 0 ; Only workout clicking on the button
	EndIf
	; Proceed the default AutoIt3 internal message commands.
	; You also can complete let the line out.
	; !!! But only 'Return' (without any value) will not proceed
	; the default AutoIt3-message in the future !!!
	Return $GUI_RUNDEFMSG
EndFunc   ;==>MY_WM_COMMAND

; RePost a WM_COMMAND message to a ctrl in a gui window
Func PostButtonClick($hWnd, $nCtrlID)
	DllCall("user32.dll", "int", "PostMessage", _
			"hwnd", $hWnd, _
			"int", $WM_COMMAND, _
			"int", BitAND($nCtrlID, 0x0000FFFF), _
			"hwnd", GUICtrlGetHandle($nCtrlID))
EndFunc   ;==>PostButtonClick

; Draw the button
Func MY_WM_DRAWITEM($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam, $lParam
	Local $tDrawItem = DllStructCreate("uint;uint;uint;uint;uint;uint;uint;int[4];dword", $lParam)
	Local Const $ODT_BUTTON = 4

	Local $nCtlType = DllStructGetData($tDrawItem, 1)
	If $nCtlType = $ODT_BUTTON Then
		; Local $nCtrlID = DllStructGetData($tDrawItem, 2)
		Local $nItemState = DllStructGetData($tDrawItem, 5)
		Local $hCtrl = DllStructGetData($tDrawItem, 6)
		Local $hDC = DllStructGetData($tDrawItem, 7)
		Local $nLeft = DllStructGetData($tDrawItem, 8, 1)
		Local $nTop = DllStructGetData($tDrawItem, 8, 2)
		Local $nRight = DllStructGetData($tDrawItem, 8, 3)
		Local $nBottom = DllStructGetData($tDrawItem, 8, 4)
		Local $sText = "Ownerdrawn Button"
		Local $nTextColor = 0x5555DD
		Local $nBackColor = 0xFFEEDD
		DrawButton($hWnd, $hCtrl, $hDC, $nLeft, $nTop, $nRight, $nBottom, $nItemState, $sText, $nTextColor, $nBackColor)
		$tDrawItem = 0
		Return 1
	EndIf

	$tDrawItem = 0
	Return $GUI_RUNDEFMSG ; Proceed the default AutoIt3 internal message commands
EndFunc   ;==>MY_WM_DRAWITEM

; The main drawing procedure
Func DrawButton($hWnd, $hCtrl, $hDC, $nLeft, $nTop, $nRight, $nBottom, $nItemState, $sText, $nTextColor, $nBackColor)
	#forceref $hWnd
	;Local $bDefault	= FALSE
	Local Const $GWL_STYLE = -16
	Local Const $ODS_SELECTED = 0x0001
	Local Const $ODS_GRAYED = 0x0002
	Local Const $ODS_DISABLED = 0x0004
	; Local Const $ODS_CHECKED = 0x0008
	Local Const $ODS_FOCUS = 0x0010
	; Local Const $ODS_HOTLIGHT = 0x0040
	; Local Const $ODS_INACTIVE = 0x0080
	; Local Const $ODS_NOACCEL = 0x0100
	; Local Const $ODS_NOFOCUSRECT = 0x0200
	Local Const $DFC_BUTTON = 4
	Local Const $DFCS_BUTTONPUSH = 0x0010
	; Local $bChecked = BitAND($nItemState, $ODS_CHECKED)
	Local $bFocused = BitAND($nItemState, $ODS_FOCUS)
	Local $bGrayed = BitAND($nItemState, BitOR($ODS_GRAYED, $ODS_DISABLED))
	Local $bSelected = BitAND($nItemState, $ODS_SELECTED)

	Local $tRECT = DllStructCreate("int;int;int;int")
	DllStructSetData($tRECT, 1, $nLeft)
	DllStructSetData($tRECT, 2, $nTop)
	DllStructSetData($tRECT, 3, $nRight)
	DllStructSetData($tRECT, 4, $nBottom)

	Local $nClrTxt
	If $bGrayed Then
		$nClrTxt = SetTextColor($hDC, GetSysColor($COLOR_HIGHLIGHTTEXT))
	ElseIf $nTextColor = -1 Then
		$nClrTxt = SetTextColor($hDC, GetSysColor($COLOR_BTNTEXT))
	Else
		$nClrTxt = SetTextColor($hDC, $nTextColor)
	EndIf

	Local $hBrush, $nClrSel
	If $nBackColor = -1 Then
		$hBrush = GetSysColorBrush($COLOR_BTNFACE)
		$nClrSel = GetSysColor($COLOR_BTNFACE)
	Else
		$hBrush = CreateSolidBrush($nBackColor)
		$nClrSel = $nBackColor;
	EndIf

	Local $nClrBk = SetBkColor($hDC, $nClrSel)
	Local $hOldBrush = SelectObject($hDC, $hBrush)

	Local $nTmpLeft = $nLeft
	Local $nTmpTop = $nTop
	Local $nTmpRight = $nRight
	Local $nTmpBottom = $nBottom

	If $bSelected Then
		InflateRect($nTmpLeft, $nTmpTop, $nTmpRight, $nTmpBottom, -1, -1)
		Local $hBrushSel = CreateSolidBrush(GetSysColor($COLOR_BTNSHADOW))
		FrameRect($hDC, $nTmpLeft, $nTmpTop, $nTmpRight, $nTmpBottom, $hBrushSel)
		DeleteObject($hBrushSel)
	Else
		If $bFocused And Not $bSelected Then InflateRect($nTmpLeft, $nTmpTop, $nTmpRight, $nTmpBottom, -1, -1)
		DrawFrameControl($hDC, $nTmpLeft, $nTmpTop, $nTmpRight, $nTmpBottom, $DFC_BUTTON, $DFCS_BUTTONPUSH)
	EndIf

	$nTmpLeft = $nLeft
	$nTmpTop = $nTop
	$nTmpRight = $nRight
	$nTmpBottom = $nBottom

	If $bSelected Then
		InflateRect($nTmpLeft, $nTmpTop, $nTmpRight, $nTmpBottom, -2, -2)
	Else
		If $bFocused And Not $bSelected Then
			InflateRect($nTmpLeft, $nTmpTop, $nTmpRight, $nTmpBottom, -3, -3)
			$nTmpLeft -= 1
			$nTmpTop -= 1
		Else
			InflateRect($nTmpLeft, $nTmpTop, $nTmpRight, $nTmpBottom, -2, -2)
			$nTmpLeft -= 1
			$nTmpTop -= 1
		EndIf
	EndIf

	FillRect($hDC, $nTmpLeft, $nTmpTop, $nTmpRight, $nTmpBottom, $hBrush)

	If $bSelected Or $bGrayed Then
		$nTmpLeft = $nTmpLeft + 2
		$nTmpTop = $nTmpTop + 2
	EndIf

	Local $iFlags = BitOR($DT_NOCLIP, $DT_CENTER, $DT_VCENTER)

	If Not BitAND(GetWindowLong($hCtrl, $GWL_STYLE), $BS_MULTILINE) Then $iFlags = BitOR($iFlags, $DT_SINGLELINE)

	DrawText($hDC, $sText, $nTmpLeft, $nTmpTop, $nTmpRight, $nTmpBottom, $iFlags)

	If $bGrayed Then
		$nTmpLeft = $nLeft
		$nTmpTop = $nTop
		$nTmpRight = $nRight
		$nTmpBottom = $nBottom

		$nTmpLeft -= 1

		$nClrTxt = SetTextColor($hDC, GetSysColor($COLOR_GRAYTEXT))
		DrawText($hDC, $sText, $nTmpLeft, $nTmpTop, $nTmpRight, $nTmpBottom, BitOR($DT_NOCLIP, $DT_CENTER, $DT_VCENTER, $DT_SINGLELINE))
	EndIf

	$nTmpLeft = $nLeft
	$nTmpTop = $nTop
	$nTmpRight = $nRight
	$nTmpBottom = $nBottom

	If $bFocused Then
		$hBrush = CreateSolidBrush(0)
		FrameRect($hDC, $nTmpLeft, $nTmpTop, $nTmpRight, $nTmpBottom, $hBrush)

		$nTmpLeft = $nLeft
		$nTmpTop = $nTop
		$nTmpRight = $nRight
		$nTmpBottom = $nBottom

		InflateRect($nTmpLeft, $nTmpTop, $nTmpRight, $nTmpBottom, -4, -4)
		DrawFocusRect($hDC, $nTmpLeft, $nTmpTop, $nTmpRight, $nTmpBottom)
	EndIf

	SelectObject($hDC, $hOldBrush)
	DeleteObject($hBrush)
	SetTextColor($hDC, $nClrTxt)
	SetBkColor($hDC, $nClrBk)

	Return 1
EndFunc   ;==>DrawButton

; Some graphic / windows functions
Func CreateSolidBrush($nColor)
	Local $hBrush = DllCall("gdi32.dll", "hwnd", "CreateSolidBrush", "int", $nColor)
	Return $hBrush[0]
EndFunc   ;==>CreateSolidBrush

Func GetSysColor($nIndex)
	Local $nColor = DllCall("user32.dll", "int", "GetSysColor", "int", $nIndex)
	Return $nColor[0]
EndFunc   ;==>GetSysColor

Func GetSysColorBrush($nIndex)
	Local $hBrush = DllCall("user32.dll", "hwnd", "GetSysColorBrush", "int", $nIndex)
	Return $hBrush[0]
EndFunc   ;==>GetSysColorBrush

Func DrawFrameControl($hDC, $nLeft, $nTop, $nRight, $nBottom, $nType, $nState)
	Local $tRECT = DllStructCreate("int;int;int;int")

	DllStructSetData($tRECT, 1, $nLeft)
	DllStructSetData($tRECT, 2, $nTop)
	DllStructSetData($tRECT, 3, $nRight)
	DllStructSetData($tRECT, 4, $nBottom)

	DllCall("user32.dll", "int", "DrawFrameControl", "hwnd", $hDC, "struct*", $tRECT, "int", $nType, "int", $nState)

	$tRECT = 0
EndFunc   ;==>DrawFrameControl

Func DrawFocusRect($hDC, $nLeft, $nTop, $nRight, $nBottom)
	Local $tRECT = DllStructCreate("int;int;int;int")

	DllStructSetData($tRECT, 1, $nLeft)
	DllStructSetData($tRECT, 2, $nTop)
	DllStructSetData($tRECT, 3, $nRight)
	DllStructSetData($tRECT, 4, $nBottom)

	DllCall("user32.dll", "int", "DrawFocusRect", "hwnd", $hDC, "struct*", $tRECT)

	$tRECT = 0
EndFunc   ;==>DrawFocusRect

Func DrawText($hDC, $sText, $nLeft, $nTop, $nRight, $nBottom, $nFormat)
	Local $nLen = StringLen($sText)

	Local $tRECT = DllStructCreate("int;int;int;int")
	DllStructSetData($tRECT, 1, $nLeft)
	DllStructSetData($tRECT, 2, $nTop)
	DllStructSetData($tRECT, 3, $nRight)
	DllStructSetData($tRECT, 4, $nBottom)

	Local $tText = DllStructCreate("char[260]")
	DllStructSetData($tText, 1, $sText)

	DllCall("user32.dll", "int", "DrawText", "hwnd", $hDC, "struct*", $tText, "int", $nLen, "struct*", $tRECT, "int", $nFormat)

	$tRECT = 0
	$tText = 0
EndFunc   ;==>DrawText

Func FillRect($hDC, $nLeft, $nTop, $nRight, $nBottom, $hBrush)
	Local $tRECT = DllStructCreate("int;int;int;int")

	DllStructSetData($tRECT, 1, $nLeft)
	DllStructSetData($tRECT, 2, $nTop)
	DllStructSetData($tRECT, 3, $nRight)
	DllStructSetData($tRECT, 4, $nBottom)

	DllCall("user32.dll", "int", "FillRect", "hwnd", $hDC, "struct*", $tRECT, "hwnd", $hBrush)

	$tRECT = 0
EndFunc   ;==>FillRect

Func FrameRect($hDC, $nLeft, $nTop, $nRight, $nBottom, $hBrush)
	Local $tRECT = DllStructCreate("int;int;int;int")

	DllStructSetData($tRECT, 1, $nLeft)
	DllStructSetData($tRECT, 2, $nTop)
	DllStructSetData($tRECT, 3, $nRight)
	DllStructSetData($tRECT, 4, $nBottom)

	DllCall("user32.dll", "int", "FrameRect", "hwnd", $hDC, "struct*", $tRECT, "hwnd", $hBrush)

	$tRECT = 0
EndFunc   ;==>FrameRect

Func InflateRect(ByRef $nLeft, ByRef $nTop, ByRef $nRight, ByRef $nBottom, $nX, $nY)
	Local $tRECT = DllStructCreate("int;int;int;int")

	DllStructSetData($tRECT, 1, $nLeft)
	DllStructSetData($tRECT, 2, $nTop)
	DllStructSetData($tRECT, 3, $nRight)
	DllStructSetData($tRECT, 4, $nBottom)

	DllCall("user32.dll", "int", "InflateRect", "struct*", $tRECT, "int", $nX, "int", $nY)

	$nLeft = DllStructGetData($tRECT, 1)
	$nTop = DllStructGetData($tRECT, 2)
	$nRight = DllStructGetData($tRECT, 3)
	$nBottom = DllStructGetData($tRECT, 4)

	$tRECT = 0
EndFunc   ;==>InflateRect

Func SetBkColor($hDC, $nColor)
	Local $nOldColor = DllCall("gdi32.dll", "int", "SetBkColor", "hwnd", $hDC, "int", $nColor)
	Return $nOldColor[0]
EndFunc   ;==>SetBkColor

Func SetTextColor($hDC, $nColor)
	Local $nOldColor = DllCall("gdi32.dll", "int", "SetTextColor", "hwnd", $hDC, "int", $nColor)
	Return $nOldColor[0]
EndFunc   ;==>SetTextColor

Func SelectObject($hDC, $hObj)
	Local $hOldObj = DllCall("gdi32.dll", "hwnd", "SelectObject", "hwnd", $hDC, "hwnd", $hObj)
	Return $hOldObj[0]
EndFunc   ;==>SelectObject

Func DeleteObject($hObj)
	DllCall("gdi32.dll", "hwnd", "DeleteObject", "hwnd", $hObj)
EndFunc   ;==>DeleteObject

Func GetWindowLong($hWnd, $nIndex)
	Local $nVal = DllCall("user32.dll", "int", "GetWindowLong", "hwnd", $hWnd, "int", $nIndex)
	Return $nVal[0]
EndFunc   ;==>GetWindowLong
