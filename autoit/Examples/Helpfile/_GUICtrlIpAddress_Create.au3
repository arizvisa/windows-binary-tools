#include <GUIConstantsEx.au3>
#include <GuiIPAddress.au3>
#include <WindowsConstants.au3>

Global $g_hIPAddress

Example()

Func Example()
	Local $hGui

	$hGui = GUICreate("IP Address Control Create Example", 400, 300)
	$g_hIPAddress = _GUICtrlIpAddress_Create($hGui, 10, 10)
	GUISetState(@SW_SHOW)

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	_GUICtrlIpAddress_Set($g_hIPAddress, "24.168.2.128")

	; Wait for user to close GUI
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

Func WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam
	Local $hWndFrom, $iCode, $tNMHDR
	Local $tInfo

	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $g_hIPAddress
			Switch $iCode
				Case $IPN_FIELDCHANGED ; Sent when the user changes a field in the control or moves from one field to another
					$tInfo = DllStructCreate($tagNMIPADDRESS, $lParam)
					_DebugPrint("$IPN_FIELDCHANGED" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tInfo, "hWndFrom") & @CRLF & _
							"-->IDFrom:" & @TAB & DllStructGetData($tInfo, "IDFrom") & @CRLF & _
							"-->Code:" & @TAB & DllStructGetData($tInfo, "Code") & @CRLF & _
							"-->Field:" & @TAB & DllStructGetData($tInfo, "Field") & @CRLF & _
							"-->Value:" & @TAB & DllStructGetData($tInfo, "Value"))
					; The return value is ignored
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
