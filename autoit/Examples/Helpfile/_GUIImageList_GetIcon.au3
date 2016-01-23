#include <GUIConstantsEx.au3>
#include <GuiImageList.au3>
#include <GuiStatusBar.au3>
#include <MsgBoxConstants.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $g_hStatus, $g_idMemo

Example()

Func Example()
	Local $hGUI, $ahIcons[2], $hImage
	Local $aParts[4] = [75, 150, 300, 400]

	; Create GUI
	$hGUI = GUICreate("ImageList Get Icon", 400, 300)
	$g_hStatus = _GUICtrlStatusBar_Create($hGUI)

	; Create memo control
	$g_idMemo = GUICtrlCreateEdit("", 2, 2, 396, 274, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	; Set parts
	_GUICtrlStatusBar_SetParts($g_hStatus, $aParts)
	_GUICtrlStatusBar_SetText($g_hStatus, "Part 1")
	_GUICtrlStatusBar_SetText($g_hStatus, "Part 2", 1)

	; Load images
	$hImage = _GUIImageList_Create(11, 11)
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($g_hStatus, 0xFF0000, 11, 11))
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($g_hStatus, 0x00FF00, 11, 11))
	_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($g_hStatus, 0x0000FF, 11, 11))

	; Set icons
	$ahIcons[0] = _GUIImageList_GetIcon($hImage, 1)
	$ahIcons[1] = _GUIImageList_GetIcon($hImage, 2)
	_GUICtrlStatusBar_SetIcon($g_hStatus, 0, $ahIcons[0])
	_GUICtrlStatusBar_SetIcon($g_hStatus, 1, $ahIcons[1])

	; Show icon handles
	MemoWrite("Part 1 icon handle .: 0x" & Hex($ahIcons[0]))
	MemoWrite("Part 2 icon handle .: 0x" & Hex($ahIcons[1]))

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	; Free icons
	MsgBox($MB_SYSTEMMODAL, "Information", "Icon 1 Destroyed? " & _GUIImageList_DestroyIcon($ahIcons[0]))
	MsgBox($MB_SYSTEMMODAL, "Information", "Icon 2 Destroyed? " & _GUIImageList_DestroyIcon($ahIcons[1]))
	GUIDelete()
EndFunc   ;==>Example

; Write message to memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite

Func WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR

	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Local $tInfo
	Switch $hWndFrom
		Case $g_hStatus
			Switch $iCode
				Case $NM_CLICK ; The user has clicked the left mouse button within the control
					$tInfo = DllStructCreate($tagNMMOUSE, $lParam)
					$hWndFrom = HWnd(DllStructGetData($tInfo, "hWndFrom"))
					$iIDFrom = DllStructGetData($tInfo, "IDFrom")
					$iCode = DllStructGetData($tInfo, "Code")
					_DebugPrint("$NM_CLICK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->ItemSpec:" & @TAB & DllStructGetData($tInfo, "ItemSpec") & @CRLF & _
							"-->ItemData:" & @TAB & DllStructGetData($tInfo, "ItemData") & @CRLF & _
							"-->X:" & @TAB & DllStructGetData($tInfo, "X") & @CRLF & _
							"-->Y:" & @TAB & DllStructGetData($tInfo, "Y") & @CRLF & _
							"-->HitInfo:" & @TAB & DllStructGetData($tInfo, "HitInfo"))
					Return True ; indicate that the mouse click was handled and suppress default processing by the system
					; Return FALSE ;to allow default processing of the click.
				Case $NM_DBLCLK ; The user has double-clicked the left mouse button within the control
					$tInfo = DllStructCreate($tagNMMOUSE, $lParam)
					$hWndFrom = HWnd(DllStructGetData($tInfo, "hWndFrom"))
					$iIDFrom = DllStructGetData($tInfo, "IDFrom")
					$iCode = DllStructGetData($tInfo, "Code")
					_DebugPrint("$NM_DBLCLK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->ItemSpec:" & @TAB & DllStructGetData($tInfo, "ItemSpec") & @CRLF & _
							"-->ItemData:" & @TAB & DllStructGetData($tInfo, "ItemData") & @CRLF & _
							"-->X:" & @TAB & DllStructGetData($tInfo, "X") & @CRLF & _
							"-->Y:" & @TAB & DllStructGetData($tInfo, "Y") & @CRLF & _
							"-->HitInfo:" & @TAB & DllStructGetData($tInfo, "HitInfo"))
					Return True ; indicate that the mouse click was handled and suppress default processing by the system
					; Return FALSE ;to allow default processing of the click.
				Case $NM_RCLICK ; The user has clicked the right mouse button within the control
					$tInfo = DllStructCreate($tagNMMOUSE, $lParam)
					$hWndFrom = HWnd(DllStructGetData($tInfo, "hWndFrom"))
					$iIDFrom = DllStructGetData($tInfo, "IDFrom")
					$iCode = DllStructGetData($tInfo, "Code")
					_DebugPrint("$NM_RCLICK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->ItemSpec:" & @TAB & DllStructGetData($tInfo, "ItemSpec") & @CRLF & _
							"-->ItemData:" & @TAB & DllStructGetData($tInfo, "ItemData") & @CRLF & _
							"-->X:" & @TAB & DllStructGetData($tInfo, "X") & @CRLF & _
							"-->Y:" & @TAB & DllStructGetData($tInfo, "Y") & @CRLF & _
							"-->HitInfo:" & @TAB & DllStructGetData($tInfo, "HitInfo"))
					Return True ; indicate that the mouse click was handled and suppress default processing by the system
					; Return FALSE ;to allow default processing of the click.
				Case $NM_RDBLCLK ; The user has double-clicked the right mouse button within the control
					$tInfo = DllStructCreate($tagNMMOUSE, $lParam)
					$hWndFrom = HWnd(DllStructGetData($tInfo, "hWndFrom"))
					$iIDFrom = DllStructGetData($tInfo, "IDFrom")
					$iCode = DllStructGetData($tInfo, "Code")
					_DebugPrint("$NM_RDBLCLK" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->ItemSpec:" & @TAB & DllStructGetData($tInfo, "ItemSpec") & @CRLF & _
							"-->ItemData:" & @TAB & DllStructGetData($tInfo, "ItemData") & @CRLF & _
							"-->X:" & @TAB & DllStructGetData($tInfo, "X") & @CRLF & _
							"-->Y:" & @TAB & DllStructGetData($tInfo, "Y") & @CRLF & _
							"-->HitInfo:" & @TAB & DllStructGetData($tInfo, "HitInfo"))
					Return True ; indicate that the mouse click was handled and suppress default processing by the system
					; Return FALSE ;to allow default processing of the click.
				Case $SBN_SIMPLEMODECHANGE ; Simple mode changes
					_DebugPrint("$SBN_SIMPLEMODECHANGE" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode)
					; No return value
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _DebugPrint($s_Text, $sLine = @ScriptLineNumber)
	ConsoleWrite( _
			"!===========================================================" & @CRLF & _
			"+======================================================" & @CRLF & _
			"-->Line(" & StringFormat("%04d", $sLine) & "):" & @TAB & $s_Text & @CRLF & _
			"+======================================================" & @CRLF)
EndFunc   ;==>_DebugPrint
