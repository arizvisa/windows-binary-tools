; Open browser to the AutoIt homepage, loop through the links
; on the page and click on the link with text "overview"
; using a sub-string match.

#include <IE.au3>

Local $oIE = _IECreate("http://www.autoitscript.com")

Local $sMyString = "overview"
Local $oLinks = _IELinkGetCollection($oIE)
For $oLink In $oLinks
	Local $sLinkText = _IEPropertyGet($oLink, "innerText")
	If StringInStr($sLinkText, $sMyString) Then
		_IEAction($oLink, "click")
		ExitLoop
	EndIf
Next
