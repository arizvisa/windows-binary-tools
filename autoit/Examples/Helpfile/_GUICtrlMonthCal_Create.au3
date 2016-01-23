#include <GUIConstantsEx.au3>
#include <GuiMonthCal.au3>
#include <WindowsConstants.au3>

Global $g_hMonthCal

Example()

Func Example()
	Local $hGUI

	; Create GUI
	$hGUI = GUICreate("Month Calendar Create", 400, 300)
	$g_hMonthCal = _GUICtrlMonthCal_Create($hGUI, 4, 4, $WS_BORDER)
	GUISetState(@SW_SHOW)

	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example

Func WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $tInfo

	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $g_hMonthCal
			Switch $iCode
				Case $MCN_GETDAYSTATE ; Sent by a month calendar control to request information about how individual days should be displayed
					$tInfo = DllStructCreate($tagNMDAYSTATE, $lParam)
					_DebugPrint("$MCN_GETDAYSTATE" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->Year:" & @TAB & DllStructGetData($tInfo, "Year") & @CRLF & _
							"-->Month:" & @TAB & DllStructGetData($tInfo, "Month") & @CRLF & _
							"-->DOW:" & @TAB & DllStructGetData($tInfo, "DOW") & @CRLF & _
							"-->Day:" & @TAB & DllStructGetData($tInfo, "Day") & @CRLF & _
							"-->Hour:" & @TAB & DllStructGetData($tInfo, "Hour") & @CRLF & _
							"-->Minute:" & @TAB & DllStructGetData($tInfo, "Minute") & @CRLF & _
							"-->Second:" & @TAB & DllStructGetData($tInfo, "Second") & @CRLF & _
							"-->MSecond:" & @TAB & DllStructGetData($tInfo, "MSecond") & @CRLF & _
							"-->DayState:" & @TAB & DllStructGetData($tInfo, "DayState") & @CRLF & _
							"-->pDayState:" & @TAB & DllStructGetData($tInfo, "pDayState"))
					; Address of an array of MONTHDAYSTATE (DWORD bit field that holds the state of each day in a month)
					; Each bit (1 through 31) represents the state of a day in a month. If a bit is on, the corresponding day will
					; be displayed in bold; otherwise it will be displayed with no emphasis.
					; No return value
				Case $MCN_SELCHANGE ; Sent by a month calendar control when the currently selected date or range of dates changes
					$tInfo = DllStructCreate($tagNMSELCHANGE, $lParam)
					_DebugPrint("$MCN_SELCHANGE" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->BegYear:" & @TAB & DllStructGetData($tInfo, "BegYear") & @CRLF & _
							"-->BegMonth:" & @TAB & DllStructGetData($tInfo, "BegMonth") & @CRLF & _
							"-->BegDOW:" & @TAB & DllStructGetData($tInfo, "BegDOW") & @CRLF & _
							"-->BegDay:" & @TAB & DllStructGetData($tInfo, "BegDay") & @CRLF & _
							"-->BegHour:" & @TAB & DllStructGetData($tInfo, "BegHour") & @CRLF & _
							"-->BegMinute:" & @TAB & DllStructGetData($tInfo, "BegMinute") & @CRLF & _
							"-->BegSecond:" & @TAB & DllStructGetData($tInfo, "BegSecond") & @CRLF & _
							"-->BegMSeconds:" & @TAB & DllStructGetData($tInfo, "BegMSeconds") & @CRLF & _
							"-->EndYear:" & @TAB & DllStructGetData($tInfo, "EndYear") & @CRLF & _
							"-->EndMonth:" & @TAB & DllStructGetData($tInfo, "EndMonth") & @CRLF & _
							"-->EndDOW:" & @TAB & DllStructGetData($tInfo, "EndDOW") & @CRLF & _
							"-->EndDay:" & @TAB & DllStructGetData($tInfo, "EndDay") & @CRLF & _
							"-->EndHour:" & @TAB & DllStructGetData($tInfo, "EndHour") & @CRLF & _
							"-->EndMinute:" & @TAB & DllStructGetData($tInfo, "EndMinute") & @CRLF & _
							"-->EndSecond:" & @TAB & DllStructGetData($tInfo, "EndSecond") & @CRLF & _
							"-->EndMSeconds:" & @TAB & DllStructGetData($tInfo, "EndMSeconds"))
					; No return value
				Case $MCN_SELECT ; Sent by a month calendar control when the user makes an explicit date selection within a month calendar control
					$tInfo = DllStructCreate($tagNMSELCHANGE, $lParam)
					_DebugPrint("$MCN_SELECT" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
							"-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
							"-->Code:" & @TAB & $iCode & @CRLF & _
							"-->BegYear:" & @TAB & DllStructGetData($tInfo, "BegYear") & @CRLF & _
							"-->BegMonth:" & @TAB & DllStructGetData($tInfo, "BegMonth") & @CRLF & _
							"-->BegDOW:" & @TAB & DllStructGetData($tInfo, "BegDOW") & @CRLF & _
							"-->BegDay:" & @TAB & DllStructGetData($tInfo, "BegDay") & @CRLF & _
							"-->BegHour:" & @TAB & DllStructGetData($tInfo, "BegHour") & @CRLF & _
							"-->BegMinute:" & @TAB & DllStructGetData($tInfo, "BegMinute") & @CRLF & _
							"-->BegSecond:" & @TAB & DllStructGetData($tInfo, "BegSecond") & @CRLF & _
							"-->BegMSeconds:" & @TAB & DllStructGetData($tInfo, "BegMSeconds") & @CRLF & _
							"-->EndYear:" & @TAB & DllStructGetData($tInfo, "EndYear") & @CRLF & _
							"-->EndMonth:" & @TAB & DllStructGetData($tInfo, "EndMonth") & @CRLF & _
							"-->EndDOW:" & @TAB & DllStructGetData($tInfo, "EndDOW") & @CRLF & _
							"-->EndDay:" & @TAB & DllStructGetData($tInfo, "EndDay") & @CRLF & _
							"-->EndHour:" & @TAB & DllStructGetData($tInfo, "EndHour") & @CRLF & _
							"-->EndMinute:" & @TAB & DllStructGetData($tInfo, "EndMinute") & @CRLF & _
							"-->EndSecond:" & @TAB & DllStructGetData($tInfo, "EndSecond") & @CRLF & _
							"-->EndMSeconds:" & @TAB & DllStructGetData($tInfo, "EndMSeconds"))
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
