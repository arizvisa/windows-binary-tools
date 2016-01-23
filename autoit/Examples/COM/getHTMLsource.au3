; WINHTTP Object example
;
; Retrieve the HTML source from a given URL
;
; Derived from a KiXtart script BBCodeParser.kix by Lonkero
;
; See also: http://www.gwspikval.com/jooel/scripts/BBCodeParser/Older%20versions/2.0.1/BBCodeParser2.kix
; and
; http://msdn.microsoft.com/library/en-us/winhttp/http/winhttprequest.asp

#include <GUIConstantsEX.au3>

Example()
Exit

Func Example()

	Local $sURL = "http://www.AutoItScript.com"

	; Create a simple GUI for output
	GUICreate("Event Test", 640, 480)
	Local $idGUIEdit = GUICtrlCreateEdit("HTTP Source Test:" & @CRLF, 10, 10, 600, 400)
	GUISetState() ; Show GUI

	; Downloading content from $sURL website using "winhttp.winhttprequest.5.1" object
	Local $oHttpObj = ObjCreate("winhttp.winhttprequest.5.1")
	$oHttpObj.open("GET", $sURL)
	$oHttpObj.send()
	Local $sHTMLSource = $oHttpObj.Responsetext

	; Filling Edit controls, data retrieved from the web
	GUICtrlSetData($idGUIEdit, "The HTML source of " & $sURL & " is:" & @CRLF & @CRLF & StringAddCR($sHTMLSource), "append")

	; Waiting for user to close the window
	Local $iMsg
	While 1
		$iMsg = GUIGetMsg()
		If $iMsg = $GUI_EVENT_CLOSE Then ExitLoop
	WEnd

	GUIDelete()

EndFunc   ;==>Example
