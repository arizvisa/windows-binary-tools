; Create an invisible browser window, navigate to a
; website, retrieve some information and Quit

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IECreate("http://sourceforge.net")
; Display the innerText on an element on the page with a name of "sfmarquee"
Local $oMarquee = _IEGetObjByName($oIE, "sfmarquee")
If IsObj($oMarquee) Then
	MsgBox($MB_SYSTEMMODAL, "SourceForge Information", $oMarquee.innerText)
Else
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), "SourceForge Information", "NO sfmarquee FOUND !!!")
EndIf
_IEQuit($oIE)
