#include <GUIConstantsEx.au3>
#include <GuiHeader.au3>
#include <WindowsConstants.au3>

Global $g_hHeader

Example()

Func Example()
	Local $hGUI

	; Create GUI
	$hGUI = GUICreate("Header", 400, 300)
	$g_hHeader = _GUICtrlHeader_Create($hGUI)
	_GUICtrlHeader_SetUnicodeFormat($g_hHeader, True)
	GUISetState(@SW_SHOW)

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	; Add columns
	_GUICtrlHeader_AddItem($g_hHeader, "Column 1", 100)
	_GUICtrlHeader_AddItem($g_hHeader, "Column 2", 100)
	_GUICtrlHeader_AddItem($g_hHeader, "Column 3", 100)
	_GUICtrlHeader_AddItem($g_hHeader, "Column 4", 100)

	; Clear all filters
	_GUICtrlHeader_ClearFilterAll($g_hHeader)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

Func WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam
	Local $hWndFrom, $iCode
	Local $tNMHDR, $tNMHEADER, $tNMHDFILTERBTNCLICK, $tNMHDDISPINFO

	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $g_hHeader
			Switch $iCode
				Case $HDN_BEGINDRAG ; Sent by a header control when a drag operation has begun on one of its items
					$tNMHEADER = DllStructCreate($tagNMHEADER, $lParam)
					_DebugPrint("$HDN_BEGINDRAG" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tNMHEADER, "hWndFrom") & @CRLF & _
							"-->IDFrom:" & @TAB & DllStructGetData($tNMHEADER, "IDFrom") & @CRLF & _
							"-->Code:" & @TAB & DllStructGetData($tNMHEADER, "Code") & @CRLF & _
							"-->Item:" & @TAB & DllStructGetData($tNMHEADER, "Item") & @CRLF & _
							"-->Button:" & @TAB & DllStructGetData($tNMHEADER, "Button"))
					Return False ; To allow the header control to automatically manage drag-and-drop operations
					; Return True  ; To indicate external (manual) drag-and-drop management allows the owner of the
					; control to provide custom services as part of the drag-and-drop process
				Case $HDN_BEGINTRACK, $HDN_BEGINTRACKW ; Notifies a header control's parent window that the user has begun dragging a divider in the control
					$tNMHEADER = DllStructCreate($tagNMHEADER, $lParam)
					_DebugPrint("$HDN_BEGINTRACK" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tNMHEADER, "hWndFrom") & @CRLF & _
							"-->IDFrom:" & @TAB & DllStructGetData($tNMHEADER, "IDFrom") & @CRLF & _
							"-->Code:" & @TAB & DllStructGetData($tNMHEADER, "Code") & @CRLF & _
							"-->Item:" & @TAB & DllStructGetData($tNMHEADER, "Item") & @CRLF & _
							"-->Button:" & @TAB & DllStructGetData($tNMHEADER, "Button"))
					Return False ; To allow tracking of the divider
					; Return True  ; To prevent tracking
				Case $HDN_DIVIDERDBLCLICK, $HDN_DIVIDERDBLCLICKW ; Notifies a header control's parent window that the user double-clicked the divider area of the control
					$tNMHEADER = DllStructCreate($tagNMHEADER, $lParam)
					_DebugPrint("$HDN_DIVIDERDBLCLICK" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tNMHEADER, "hWndFrom") & @CRLF & _
							"-->IDFrom:" & @TAB & DllStructGetData($tNMHEADER, "IDFrom") & @CRLF & _
							"-->Code:" & @TAB & DllStructGetData($tNMHEADER, "Code") & @CRLF & _
							"-->Item:" & @TAB & DllStructGetData($tNMHEADER, "Item") & @CRLF & _
							"-->Button:" & @TAB & DllStructGetData($tNMHEADER, "Button"))
					; no return value
				Case $HDN_ENDDRAG ; Sent by a header control when a drag operation has ended on one of its items
					$tNMHEADER = DllStructCreate($tagNMHEADER, $lParam)
					_DebugPrint("$HDN_ENDDRAG" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tNMHEADER, "hWndFrom") & @CRLF & _
							"-->IDFrom:" & @TAB & DllStructGetData($tNMHEADER, "IDFrom") & @CRLF & _
							"-->Code:" & @TAB & DllStructGetData($tNMHEADER, "Code") & @CRLF & _
							"-->Item:" & @TAB & DllStructGetData($tNMHEADER, "Item") & @CRLF & _
							"-->Button:" & @TAB & DllStructGetData($tNMHEADER, "Button"))
					Return False ; To allow the control to automatically place and reorder the item
					; Return True  ; To prevent the item from being placed
				Case $HDN_ENDTRACK, $HDN_ENDTRACKW ; Notifies a header control's parent window that the user has finished dragging a divider
					$tNMHEADER = DllStructCreate($tagNMHEADER, $lParam)
					_DebugPrint("$HDN_ENDTRACK" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tNMHEADER, "hWndFrom") & @CRLF & _
							"-->IDFrom:" & @TAB & DllStructGetData($tNMHEADER, "IDFrom") & @CRLF & _
							"-->Code:" & @TAB & DllStructGetData($tNMHEADER, "Code") & @CRLF & _
							"-->Item:" & @TAB & DllStructGetData($tNMHEADER, "Item") & @CRLF & _
							"-->Button:" & @TAB & DllStructGetData($tNMHEADER, "Button"))
					; no return value
				Case $HDN_FILTERBTNCLICK ; Notifies the header control's parent window when the filter button is clicked or in response to an $HDM_SETITEM message
					$tNMHDFILTERBTNCLICK = DllStructCreate($tagNMHDFILTERBTNCLICK, $lParam)
					_DebugPrint("$HDN_FILTERBTNCLICK" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tNMHDFILTERBTNCLICK, "hWndFrom") & @CRLF & _
							"-->IDFrom:" & @TAB & DllStructGetData($tNMHDFILTERBTNCLICK, "IDFrom") & @CRLF & _
							"-->Code:" & @TAB & DllStructGetData($tNMHDFILTERBTNCLICK, "Code") & @CRLF & _
							"-->Item:" & @TAB & DllStructGetData($tNMHDFILTERBTNCLICK, "Item") & @CRLF & _
							"-->Left:" & @TAB & DllStructGetData($tNMHDFILTERBTNCLICK, "Left") & @CRLF & _
							"-->Top:" & @TAB & DllStructGetData($tNMHDFILTERBTNCLICK, "Top") & @CRLF & _
							"-->Right:" & @TAB & DllStructGetData($tNMHDFILTERBTNCLICK, "Right") & @CRLF & _
							"-->Bottom:" & @TAB & DllStructGetData($tNMHDFILTERBTNCLICK, "Bottom"))
					; Return True  ; An $HDN_FILTERCHANGE notification will be sent to the header control's parent window
					; This notification gives the parent window an opportunity to synchronize its user interface elements
					Return False ; If you do not want the notification sent
				Case $HDN_FILTERCHANGE ; Notifies the header control's parent window that the attributes of a header control filter are being changed or edited
					$tNMHEADER = DllStructCreate($tagNMHEADER, $lParam)
					_DebugPrint("$HDN_FILTERCHANGE" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tNMHEADER, "hWndFrom") & @CRLF & _
							"-->IDFrom:" & @TAB & DllStructGetData($tNMHEADER, "IDFrom") & @CRLF & _
							"-->Code:" & @TAB & DllStructGetData($tNMHEADER, "Code") & @CRLF & _
							"-->Item:" & @TAB & DllStructGetData($tNMHEADER, "Item") & @CRLF & _
							"-->Button:" & @TAB & DllStructGetData($tNMHEADER, "Button"))
					; no return value
				Case $HDN_GETDISPINFO, $HDN_GETDISPINFOW ; Sent to the owner of a header control when the control needs information about a callback header item
					$tNMHDDISPINFO = DllStructCreate($tagNMHDDISPINFO, $lParam)
					_DebugPrint("$HDN_GETDISPINFO" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tNMHDDISPINFO, "hWndFrom") & @CRLF & _
							"-->IDFrom:" & @TAB & DllStructGetData($tNMHDDISPINFO, "IDFrom") & @CRLF & _
							"-->Code:" & @TAB & DllStructGetData($tNMHDDISPINFO, "Code") & @CRLF & _
							"-->Item:" & @TAB & DllStructGetData($tNMHDDISPINFO, "Item"))
					; Return LRESULT
				Case $HDN_ITEMCHANGED, $HDN_ITEMCHANGEDW ; Notifies a header control's parent window that the attributes of a header item have changed
					$tNMHEADER = DllStructCreate($tagNMHEADER, $lParam)
					_DebugPrint("$HDN_ITEMCHANGED" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tNMHEADER, "hWndFrom") & @CRLF & _
							"-->IDFrom:" & @TAB & DllStructGetData($tNMHEADER, "IDFrom") & @CRLF & _
							"-->Code:" & @TAB & DllStructGetData($tNMHEADER, "Code") & @CRLF & _
							"-->Item:" & @TAB & DllStructGetData($tNMHEADER, "Item") & @CRLF & _
							"-->Button:" & @TAB & DllStructGetData($tNMHEADER, "Button"))
					; no return value
				Case $HDN_ITEMCHANGING, $HDN_ITEMCHANGINGW ; Notifies a header control's parent window that the attributes of a header item are about to change
					$tNMHEADER = DllStructCreate($tagNMHEADER, $lParam)
					_DebugPrint("$HDN_ITEMCHANGING" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tNMHEADER, "hWndFrom") & @CRLF & _
							"-->IDFrom:" & @TAB & DllStructGetData($tNMHEADER, "IDFrom") & @CRLF & _
							"-->Code:" & @TAB & DllStructGetData($tNMHEADER, "Code") & @CRLF & _
							"-->Item:" & @TAB & DllStructGetData($tNMHEADER, "Item") & @CRLF & _
							"-->Button:" & @TAB & DllStructGetData($tNMHEADER, "Button"))
					Return False ; To allow the changes
					; Return True  ; To prevent them
				Case $HDN_ITEMCLICK, $HDN_ITEMCLICKW ; Notifies a header control's parent window that the user clicked the control
					$tNMHEADER = DllStructCreate($tagNMHEADER, $lParam)
					_DebugPrint("$HDN_ITEMCLICK" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tNMHEADER, "hWndFrom") & @CRLF & _
							"-->IDFrom:" & @TAB & DllStructGetData($tNMHEADER, "IDFrom") & @CRLF & _
							"-->Code:" & @TAB & DllStructGetData($tNMHEADER, "Code") & @CRLF & _
							"-->Item:" & @TAB & DllStructGetData($tNMHEADER, "Item") & @CRLF & _
							"-->Button:" & @TAB & DllStructGetData($tNMHEADER, "Button"))
					; no return value
				Case $HDN_ITEMDBLCLICK, $HDN_ITEMDBLCLICKW ; Notifies a header control's parent window that the user double-clicked the control
					$tNMHEADER = DllStructCreate($tagNMHEADER, $lParam)
					_DebugPrint("$HDN_ITEMDBLCLICK" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tNMHEADER, "hWndFrom") & @CRLF & _
							"-->IDFrom:" & @TAB & DllStructGetData($tNMHEADER, "IDFrom") & @CRLF & _
							"-->Code:" & @TAB & DllStructGetData($tNMHEADER, "Code") & @CRLF & _
							"-->Item:" & @TAB & DllStructGetData($tNMHEADER, "Item") & @CRLF & _
							"-->Button:" & @TAB & DllStructGetData($tNMHEADER, "Button"))
					; no return value
				Case $HDN_TRACK, $HDN_TRACKW ; Notifies a header control's parent window that the user is dragging a divider in the header control
					$tNMHEADER = DllStructCreate($tagNMHEADER, $lParam)
					_DebugPrint("$HDN_TRACK" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tNMHEADER, "hWndFrom") & @CRLF & _
							"-->IDFrom:" & @TAB & DllStructGetData($tNMHEADER, "IDFrom") & @CRLF & _
							"-->Code:" & @TAB & DllStructGetData($tNMHEADER, "Code") & @CRLF & _
							"-->Item:" & @TAB & DllStructGetData($tNMHEADER, "Item") & @CRLF & _
							"-->Button:" & @TAB & DllStructGetData($tNMHEADER, "Button"))
					Return False ; To continue tracking the divider
					; Return True  ; To end tracking
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
