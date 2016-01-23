; Open a browser with the form example, get the collection
; of all INPUT tags and display the formname and type of each

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IE_Example("form")
Local $oInputs = _IETagNameGetCollection($oIE, "input")
Local $sTxt = ""
For $oInput In $oInputs
	$sTxt &= $oInput.type & @CRLF
Next
MsgBox($MB_SYSTEMMODAL, "Form Input Type", "Form: " & $oInput.form.name & @CRLF & @CRLF & "         Types :" & @CRLF & $sTxt)

_IEQuit($oIE)
