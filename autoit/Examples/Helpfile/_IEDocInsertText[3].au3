; Advanced example
; Insert a clock and a referrer string at the top of every page, even when you
; browse to a new location.  Uses _IEDocInsertText, _IEDocInsertHTML and
; _IEPropertySet features "innerhtml" and "referrer"

#include <IE.au3>

Global $g_oIE = _IECreate("http://www.autoitscript.com")

AdlibRegister("UpdateClock", 1000) ; Update clock once per second

While 1
	Sleep(10000)
WEnd

Exit

Func UpdateClock()
	; update as long as the browser window exists
	If Not WinExists(_IEPropertyGet($g_oIE, "hwnd")) Then Exit

	Local $sCurTime = "<font color=red><b>Current Time is: </b>" & @HOUR & ":" & @MIN & ":" & @SEC & "</font>"
	; _IEGetObjById is expected to return a NoMatch error after navigation
	;   (before DIV is inserted), so temporarily turn off notification
	_IEErrorNotify(False)
	Local $oAutoItClock = _IEGetObjById($g_oIE, "AutoItClock")
	If Not IsObj($oAutoItClock) Then ; Insert DIV element if it wasn't found
		;
		; Get reference to BODY, insert DIV, get reference to DIV, update time
		Local $oBody = _IETagNameGetCollection($g_oIE, "body", 0)
		_IEDocInsertHTML($oBody, "<div id='AutoItClock'></div>", "afterbegin")
		$oAutoItClock = _IEGetObjById($g_oIE, "AutoItClock")
		_IEPropertySet($oAutoItClock, "innerhtml", $sCurTime)
		;
		; Check referrer string, if not blank insert after clock
		_IELoadWait($g_oIE)
		Local $sReferrer = _IEPropertyGet($g_oIE, "referrer")
		If $sReferrer Then _IEDocInsertText($oAutoItClock, _
				"  Referred by: <font color=red>" & $sReferrer & "</font>", "afterend")
	Else
		_IEPropertySet($oAutoItClock, "innerhtml", $sCurTime) ; update time
	EndIf
	_IEErrorNotify(True)
EndFunc   ;==>UpdateClock
