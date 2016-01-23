; Open a browser with the basic example, get the collection
; of all elements and display the tagname and innerText of each

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IE_Example("basic")
Local $oElements = _IETagNameAllGetCollection($oIE)
For $oElement In $oElements
	If $oElement.id Then MsgBox($MB_SYSTEMMODAL, "Element Info", "Tagname: " & $oElement.tagname & @CRLF & "id: " & $oElement.id & @CRLF & "innerText: " & $oElement.innerText)
Next

_IEQuit($oIE)
