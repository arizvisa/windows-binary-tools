; Open a browser to the AutoIt Homepage, get a reference
; to the document object and display a document attribute

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IECreate("http://www.google.com")
Local $oDoc = _IEDocGetObj($oIE)
MsgBox($MB_SYSTEMMODAL, "Document Created Date", $oDoc.fileCreatedDate)
