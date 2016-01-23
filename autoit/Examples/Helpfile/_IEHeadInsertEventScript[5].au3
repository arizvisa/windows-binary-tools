; Open a browser with the AutoIt homepage, insert an
; event script into the head of the document that prevents
; navigation when any link is clicked and log the URL of the
; clicked link to the console

#include <IE.au3>

Local $oIE = _IECreate("http://www.autoitscript.com")

Local $oLinks = _IELinkGetCollection($oIE)
For $oLink In $oLinks
	Local $sLinkId = _IEPropertyGet($oLink, "uniqueid")
	If @error Then Exit
	_IEHeadInsertEventScript($oIE, $sLinkId, "onclick", "return false;")
	If @error Then Exit
	ObjEvent($oLink, "_Evt_")
Next

; idle as long as the browser window exists
While WinExists(_IEPropertyGet($oIE, "hwnd"))
	Sleep(100)
WEnd

Func _Evt_onClick()
	Local $o_Link = @COM_EventObj
	ConsoleWrite($o_Link.href & @CRLF)
EndFunc   ;==>_Evt_onClick
